// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationPayLoadModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPayLoadModel _$NotificationPayLoadModelFromJson(
    Map<String, dynamic> json) {
  return NotificationPayLoadModel(
    json['Fk_NotificationType'] as String,
    json['Target'] as String,
  );
}

Map<String, dynamic> _$NotificationPayLoadModelToJson(
        NotificationPayLoadModel instance) =>
    <String, dynamic>{
      'Fk_NotificationType': instance.Fk_NotificationType,
      'Target': instance.Target,
    };
