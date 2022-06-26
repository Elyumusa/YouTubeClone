import 'package:youtube_api/youtube_api.dart';

class ChannelModel {
  final String channelId;
  final String title;
  final String thumbnailUrl;
  final String description;

  YouTubeVideo? video;
  ChannelModel({
    required this.description,
    required this.channelId,
    required this.title,
    required this.thumbnailUrl,
  });
  ChannelModel.fromMap({required Map<String, dynamic> json})
      : thumbnailUrl = json['snippet']['thumbnails']['high']['url'],
        channelId = json['id'],
        description = json['snippet']['description'],
        title = json['snippet']['title'];
}
