import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SnoseyNotification {
  static List<NotificationGroup> _notificationGroups = [];
  static String _defaultLogo = "";
  static String _defaultSound = "";
  static late Future<dynamic> Function(String? payload) _onNotificationClick;

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
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head projectAndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_defaultLogo);

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onNotificationClick);

    final extra = json.decode(payload!);

    NotificationGroup notificationGroup = SnoseyNotification._notificationGroups
        .firstWhere((element) => element.id == extra['Fk_NotificationType']);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(notificationGroup.id, notificationGroup.name,
            importance: Importance.max,
            priority: Priority.high,
            channelShowBadge: true,
            enableVibration: true,
            groupKey: notificationGroup.groupKey,
            playSound: true,
            sound: RawResourceAndroidNotificationSound(
                SnoseyNotification._defaultSound),
            showWhen: true);

    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(threadIdentifier: notificationGroup.id);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin.show(
        int.parse(
            "${extra['Target']}${notificationGroup.id}"),
        title,
        body,
        platformChannelSpecifics,
        payload: payload);

    _showNotificationGroup(flutterLocalNotificationsPlugin, notificationGroup);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    _displayNotification(message: message);
  }

  static Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    _displayNotification(title: title, body: body, payload: payload);
  }

  static init({
    required List<NotificationGroup> notificationGroups,
    required String defaultSound,
    required String defaultLogo,
    required Future<dynamic> Function(String? payload) onNotificationClick,
  }) async {
    /* Add in main application
    await Firebase.initializeApp();
    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) {
      UserApis().editNotificationToken(value!);
    });*/
    SnoseyNotification._onNotificationClick = onNotificationClick;
    SnoseyNotification._notificationGroups = notificationGroups;
    SnoseyNotification._defaultSound = defaultSound;
    SnoseyNotification._defaultLogo = defaultLogo;

    FirebaseMessaging.onBackgroundMessage(
        SnoseyNotification._firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      _displayNotification(message: message);
    });

    //check if notification open from background
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await FlutterLocalNotificationsPlugin()
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      SnoseyNotification._onNotificationClick(notificationAppLaunchDetails.payload);
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
          AndroidNotificationDetails(notificationGroup.id,
              notificationGroup.name,
              styleInformation: inboxStyleInformation,
              setAsGroupSummary: true,
              groupKey: notificationGroup.groupKey);
      NotificationDetails groupNotificationDetailsPlatformSpecifics =
          NotificationDetails(android: groupNotificationDetails);
      await flutterLocalNotificationPlugin.show(
          0, '', '', groupNotificationDetailsPlatformSpecifics);
    }
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
