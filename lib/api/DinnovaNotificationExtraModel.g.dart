// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DinnovaNotificationExtraModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DinnovaNotificationExtraModel _$DinnovaNotificationExtraModelFromJson(
        Map<String, dynamic> json) =>
    DinnovaNotificationExtraModel()
      ..Fk_NotificationOpenType = json['Fk_NotificationOpenType'] as int
      ..Fk_NotificationType = json['Fk_NotificationType'] as int
      ..NotificationId = json['NotificationId'] as int
      ..Target = json['Target'] as String
      ..ImgUrl = json['ImgUrl'] as String
      ..LogoUrl = json['LogoUrl'] as String;

Map<String, dynamic> _$DinnovaNotificationExtraModelToJson(
        DinnovaNotificationExtraModel instance) =>
    <String, dynamic>{
      'Fk_NotificationOpenType': instance.Fk_NotificationOpenType,
      'Fk_NotificationType': instance.Fk_NotificationType,
      'NotificationId': instance.NotificationId,
      'Target': instance.Target,
      'ImgUrl': instance.ImgUrl,
      'LogoUrl': instance.LogoUrl,
    };
