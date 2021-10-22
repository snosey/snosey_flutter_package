import 'package:json_annotation/json_annotation.dart';

part 'NotificationPayLoadModel.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationPayLoadModel {
  final String Fk_NotificationType;

  final String Target;

  NotificationPayLoadModel(this.Fk_NotificationType, this.Target);

  factory NotificationPayLoadModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayLoadModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayLoadModelToJson(this);
}
