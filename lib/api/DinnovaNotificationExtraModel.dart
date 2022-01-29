import 'package:json_annotation/json_annotation.dart';

part 'DinnovaNotificationExtraModel.g.dart';

@JsonSerializable(explicitToJson: true)
class DinnovaNotificationExtraModel {
  DinnovaNotificationExtraModel();

  late int Fk_NotificationOpenType;
  late int Fk_NotificationType;
  late int NotificationId;
  late String Target;
  late String ImgUrl;
  late String LogoUrl;

  factory DinnovaNotificationExtraModel.fromJson(Map<String, dynamic> json) =>
      _$DinnovaNotificationExtraModelFromJson(json);

  Map<String, dynamic> toJson() => _$DinnovaNotificationExtraModelToJson(this);
}
