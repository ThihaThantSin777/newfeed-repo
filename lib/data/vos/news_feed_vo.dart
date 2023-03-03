import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums.dart';

part 'news_feed_vo.g.dart';

@JsonSerializable()
class NewsFeedVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'file')
  String? file;

  @JsonKey(name: 'profile')
  String? profile;

  @JsonKey(name: 'user_name')
  String? userName;

  NewsFeedVO(this.id, this.description, this.file, this.profile, this.userName);

  factory NewsFeedVO.fromJson(Map<String, dynamic> json) =>
      _$NewsFeedVOFromJson(json);

  Map<String,dynamic>toJson()=>_$NewsFeedVOToJson(this);

  @override
  String toString() {
    return 'NewsFeedVO{id: $id, description: $description, file: $file, profile: $profile, userName: $userName}';
  }

  FileType getFileType() {
    if ((file?.endsWith(".png") ?? false) ||
        (file?.endsWith(".jpg") ?? false) ||
        (file?.endsWith(".jpeg") ?? false)) {
      return FileType.image;
    }
    if ((file?.endsWith(".mkv") ?? false) ||
        (file?.endsWith(".mp4") ?? false) ||
        (file?.endsWith(".mov") ?? false)) {
      return FileType.video;
    }
    if ((file?.endsWith(".pdf") ?? false) ||
        (file?.endsWith(".txt") ?? false)) {
      return FileType.file;
    }
    return FileType.none;
  }
}
