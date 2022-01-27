import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snosey_flutter_package/api/SnoseyNotificationExtraModel.dart';

class SnoseyNotification {
  static late String _defaultLogo;

  static late String _defaultSound;
  static late Function(
      {required int fkNotification,
      required int fkNotificationOpenType,
      required dynamic isFCM,
      required String target}) _handleOpenNotification;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<dynamic> Function(String? payload) _onNotificationClick =
      (notificationPayload) async {
    if (notificationPayload == null) return;
    var notificationPayLoadModel =
        SnoseyNotificationExtraModel.fromJson(jsonDecode(notificationPayload));
    _handleOpenNotification(
      fkNotification: notificationPayLoadModel.NotificationId,
      fkNotificationOpenType: notificationPayLoadModel.Fk_NotificationOpenType,
      target: notificationPayLoadModel.Target,
      isFCM: true,
    );
  };

  static late List<NotificationGroup> _notificationGroups;

  static _displayNotification(
      {String? title,
      String? body,
      String? payload,
      RemoteMessage? message}) async {
    if (message != null) {
      title = message.data['Title'];
      body = message.data['Body'];
      payload = message.data['Extra'];
    }

    final extra = SnoseyNotificationExtraModel.fromJson(json.decode(payload!));

    NotificationGroup notificationGroup = _notificationGroups.firstWhere(
        (element) => element.id == extra.Fk_NotificationType.toString());

    var largeIcon = "", coverIcon = "";
    if (extra.LogoUrl.isNotEmpty)
      largeIcon = await _downloadAndSaveFile(extra.LogoUrl,
          extra.LogoUrl.substring(extra.LogoUrl.lastIndexOf("/")));

    if (extra.ImgUrl.isNotEmpty)
      coverIcon = await _downloadAndSaveFile(
          extra.ImgUrl, extra.ImgUrl.substring(extra.ImgUrl.lastIndexOf("/")));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(notificationGroup.id, notificationGroup.name,
            importance: Importance.max,
            priority: Priority.high,
            vibrationPattern: Int64List.fromList([1000, 1000, 500, 1000, 1000]),
            channelShowBadge: true,
            enableVibration: true,
            groupKey: notificationGroup.groupKey,
            largeIcon:
                largeIcon.isEmpty ? null : FilePathAndroidBitmap(largeIcon),
            styleInformation: coverIcon.isEmpty
                ? null
                : BigPictureStyleInformation(
                    FilePathAndroidBitmap(coverIcon),
                  ),
            playSound: true,
            sound: RawResourceAndroidNotificationSound(
                SnoseyNotification._defaultSound),
            showWhen: true);

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
        threadIdentifier: notificationGroup.id,
        sound: _defaultSound + ".wav",
        attachments: coverIcon.isEmpty
            ? null
            : <IOSNotificationAttachment>[
                //       IOSNotificationAttachment(largeIcon),
                IOSNotificationAttachment(coverIcon),
              ]);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin.show(
        int.parse("${extra.NotificationId}${notificationGroup.id}"),
        title,
        body,
        platformChannelSpecifics,
        payload: payload);

    _showNotificationGroup(flutterLocalNotificationsPlugin, notificationGroup);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("backgroundddd//" + message.data.toString());
  }

  static Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    //   _displayNotification(title: title, body: body, payload: payload); //TODO
  }

  static init(
      {required String defaultLogo,
      required String defaultSound,
      required List<NotificationGroup> notificationGroups,
      required Function(
              {required int fkNotification,
              required int fkNotificationOpenType,
              required dynamic isFCM,
              required String target})
          handleOpenNotification}) async {
    SnoseyNotification._handleOpenNotification = handleOpenNotification;
    SnoseyNotification._notificationGroups = notificationGroups;
    SnoseyNotification._defaultLogo = defaultLogo;
    SnoseyNotification._defaultSound = defaultSound;
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head projectAndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_defaultLogo);

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onNotificationClick);

    FirebaseMessaging.onBackgroundMessage(
        SnoseyNotification._firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //Foreground message in ios send auto ... android need to show manual
      if (Platform.isAndroid) _displayNotification(message: message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //background message
      onTapRemoteMessage(message);
    });

    //check if notification open from deeplinking
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await FlutterLocalNotificationsPlugin()
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      SnoseyNotification._onNotificationClick(
          notificationAppLaunchDetails.payload);
    }
  }

  static _showNotificationGroup(
      FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin,
      NotificationGroup notificationGroup) async {
    List<ActiveNotification>? activeNotifications =
        await flutterLocalNotificationPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.getActiveNotifications();

    if (activeNotifications == null) return;

    if (activeNotifications.length > 0) {
      List<String> lines =
          activeNotifications.map((e) => e.title.toString()).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
      );
      AndroidNotificationDetails groupNotificationDetails =
          AndroidNotificationDetails(
              notificationGroup.id, notificationGroup.name,
              styleInformation: inboxStyleInformation,
              setAsGroupSummary: true,
              groupKey: notificationGroup.groupKey);
      NotificationDetails groupNotificationDetailsPlatformSpecifics =
          NotificationDetails(android: groupNotificationDetails);
      await flutterLocalNotificationPlugin.show(
          0, '', '', groupNotificationDetailsPlatformSpecifics);
    }
  }

  static void onTapRemoteMessage(RemoteMessage message) {
    final extra = SnoseyNotificationExtraModel.fromJson(
        json.decode(message.data['Extra']!));
    _handleOpenNotification(
      fkNotification: extra.NotificationId,
      fkNotificationOpenType: extra.Fk_NotificationOpenType,
      target: extra.Target,
      isFCM: true,
    );
  }
}

class NotificationGroup {
  final String name;
  final String id;
  final String groupKey;

  NotificationGroup({
    required this.name,
    required this.id,
    required this.groupKey,
  });
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final File file = File(filePath);
  var image = (await NetworkAssetBundle(
    Uri.parse(url),
  ).load(url));
  await file.writeAsBytes(image.buffer.asUint8List());
  return filePath;
}
