 import 'package:json_annotation/json_annotation.dart';
import 'package:snosey_flutter_package/api/ApiResponse.dart';

part 'BaseModel.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseModel {
  int Id = 0;

  @JsonKey(ignore: true)
  ApiResponse apiResponse = ApiResponse();

  String LastModifiedAt = "";
}
