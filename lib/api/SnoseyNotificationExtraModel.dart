import 'package:json_annotation/json_annotation.dart';

part 'SnoseyNotificationExtraModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SnoseyNotificationExtraModel {
  SnoseyNotificationExtraModel();

  late int Fk_NotificationOpenType;
  late int Fk_NotificationType;
  late int NotificationId;
  late String Target;
  late String ImgUrl;
  late String LogoUrl;

  factory SnoseyNotificationExtraModel.fromJson(Map<String, dynamic> json) =>
      _$SnoseyNotificationExtraModelFromJson(json);

  Map<String, dynamic> toJson() => _$SnoseyNotificationExtraModelToJson(this);
}
