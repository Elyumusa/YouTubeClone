import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_clone/Models/channel_model.dart';

class Video {
  final String videoId;
  final String channelId;
  final String channelTitle;
  final String title;
  final String thumbnailUrl;
  final String description;
  String? duration;
  String? viewCount;
  String? likes;
  ChannelModel? channel;
  //YouTubeVideo? video;
  Video({
    required this.videoId,
    required this.channelId,
    required this.channelTitle,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });
  Video.fromMap({required Map<String, dynamic> json})
      : thumbnailUrl = json['snippet']['thumbnails']['default']['url'],
        channelId = json['snippet']['channelId'],
        channelTitle = json['snippet']['channelTitle'],
        description = json['snippet']['description'],
        title = json['snippet']['title'],
        videoId = json['id']['videoId'];
  Video.fromJson({required Map<String, dynamic> json})
      : thumbnailUrl = json['snippet']['thumbnails']['high']['url'],
        channelId = json['snippet']['channelId'],
        channelTitle = json['snippet']['channelTitle'],
        description = json['snippet']['description'],
        title = json['snippet']['title'],
        likes = json['statistics']['likeCount'],
        viewCount = json['statistics']['viewCount'],
        duration = json['contentDetails']['duration'],
        videoId = json['id'];
  @override
  String toString() {
    // TODO: implement toString
    return "Video";
  }
}
