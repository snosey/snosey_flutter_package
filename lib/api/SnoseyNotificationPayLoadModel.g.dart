// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SnoseyNotificationPayLoadModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnoseyNotificationPayLoadModel _$SnoseyNotificationPayLoadModelFromJson(
    Map<String, dynamic> json) {
  return SnoseyNotificationPayLoadModel(
    json['Fk_NotificationType'] as String,
    json['Target'] as String,
  );
}

Map<String, dynamic> _$SnoseyNotificationPayLoadModelToJson(
        SnoseyNotificationPayLoadModel instance) =>
    <String, dynamic>{
      'Fk_NotificationType': instance.Fk_NotificationType,
      'Target': instance.Target,
    };
