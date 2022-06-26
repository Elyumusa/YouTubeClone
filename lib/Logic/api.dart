import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_clone/Models/channel_model.dart';
import 'package:youtube_clone/Models/video_model.dart';

class API {
  API._();
  static final API instance = API._();
  static const String _apiKey = "AIzaSyAVslsEPozJc5pq7GZbBhAsTHmYlnNIRiU";
  final _baseUrl = "www.googleapis.com";
  String _nextPageToken = "";
  final mrbea = 'UCUaT_39o1x6qWjz7K2pWcgw';
  final playlistId = 'UUX6OQ3DkcsbYNE6H8uQQuVA';
  final beastGamingPlaylistID = 'UUIPPMRA040LQr5QPyJEbmXA';
  final beast2PlaylistID = 'UUZzvDDvaYti8Dd8bLEiSoyQ';
  final beastReactPlaylistID = 'UUUaT_39o1x6qWjz7K2pWcgw';
  final beastPhilanthropyPlaylistID = 'UUAiLfjNXkNv24uhpzUgPa6A';
  Future fetchVideosFromPlaylist({String? playlist_id}) async {
    print("started in play function");
    final parameter = {
      'part': 'snippet,contentDetails',
      'playlistId': playlist_id ?? 'UUX6OQ3DkcsbYNE6H8uQQuVA',
      'maxResults': '10',
      'pageToken': _nextPageToken,
      'key': _apiKey
    };
    final url = Uri.https(_baseUrl, "/youtube/v3/playlistItems", parameter);
    try {
      print("its in try");
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.connectionHeader: "application/json"
        }, /* body: {"grant_type": "client_credentials"}*/
      );
      print("its done getting playlist");
      print("re: ${response.body}");
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      _nextPageToken = jsonResponse['nextPageToken'] ?? '';
      List videos = jsonResponse["items"].map((item) {
        print('item $item');
        return Video(
            videoId: item['contentDetails']['videoId'],
            channelId: item['snippet']['channelId'],
            channelTitle: item['snippet']['channelTitle'],
            title: item['snippet']['title'],
            thumbnailUrl: item['snippet']['thumbnails']['medium']['url'],
            description: item['snippet']['description']);
      }).toList();
      print("videos: $videos");
      return videos;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future<List> searchF(String query) async {
    print("started searching !");
    final parameters = {
      "key": "AIzaSyAVslsEPozJc5pq7GZbBhAsTHmYlnNIRiU",
      "part": "snippet",
      "maxResults": "20",
      "q": query
    };
    final url = Uri.https(_baseUrl, "/youtube/v3/search", parameters);
    try {
      print("its in try");
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.connectionHeader: "application/json"
        }, /* body: {"grant_type": "client_credentials"}*/
      );
      print("its done getting");
      print("re: ${response.body}");
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List result = jsonResponse["items"].map((item) {
        if (item['id']['kind'] == "youtube#channel") {
          print("currently a channel");
          return ChannelModel.fromMap(json: item['snippet']);
        } else {
          print("currently a video");
          return Video.fromMap(json: item);
        }
      }).toList();
      print("finished everything:${result[1]} !");
      return result;
    } on Exception catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future getVideos(String joinedVideoIds) async {
    final parameters = {
      "id": joinedVideoIds,
      "key": _apiKey,
      "part": "snippet,contentDetails,statistics"
    };
    final url = Uri.https(_baseUrl, "/youtube/v3/videos", parameters);

    print("its in try");
    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.connectionHeader: "application/json"
        }, /* body: {"grant_type": "client_credentials"}*/
      );
      print("its done getting in getVideos: //${response.body}");
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(
          "object: ${jsonResponse["items"][0]['snippet']['thumbnails']['default']['url']}");
      List result = jsonResponse["items"].map((item) {
        final json = item;
        print("url: ${json['snippet']['thumbnails']['default']['url']}");
        print("channeldID: ${json['snippet']['channelId']}");
        print("channelTitle: ${json['snippet']['channelTitle']}");
        print("desript: ${json['snippet']['description']}");
        print("title ${json['snippet']['title']}");
        print("likeCount: ${json['statistics']['likeCount']}");
        print("vieCount: ${json['statistics']['viewCount']}");
        print("duration ${json['contentDetails']['duration'].toString()}");
        print("id ${json['id']}");
        return Video.fromJson(json: item);
      }).toList();
      print("final result: $result");
      return result;
    } on Exception catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future getChannel(String channelId) async {
    final parameters = {
      "id": channelId,
      "key": _apiKey,
      "part": "snippet,contentDetails,statistics"
    };
    final url = Uri.https(_baseUrl, "/youtube/v3/channels", parameters);
    try {
      print("its in try");
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.connectionHeader: "application/json"
        }, /* body: {"grant_type": "client_credentials"}*/
      );
      //print("its done getting channel function");
      print("re: ${response.body}");
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final channel = ChannelModel.fromMap(json: jsonResponse['items'][0]);
      print("its done getting channel function ${channel.thumbnailUrl}");
      return channel;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }
}
