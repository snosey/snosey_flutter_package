import 'package:json_annotation/json_annotation.dart';

part 'SnoseyNotificationPayLoadModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SnoseyNotificationPayLoadModel {
  final String Fk_NotificationType;

  final String Target;

  SnoseyNotificationPayLoadModel(this.Fk_NotificationType, this.Target);

  factory SnoseyNotificationPayLoadModel.fromJson(Map<String, dynamic> json) =>
      _$SnoseyNotificationPayLoadModelFromJson(json);

  Map<String, dynamic> toJson() => _$SnoseyNotificationPayLoadModelToJson(this);
}
