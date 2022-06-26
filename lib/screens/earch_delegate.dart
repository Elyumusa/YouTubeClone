import 'package:flutter/material.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/widgets/idgets.dart';

import '../Logic/api.dart';
import '../Models/video_model.dart';
import '../widgets/tryVideoCard.dart';

class SearchD extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
      IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showResults(context);
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.isNotEmpty) {
      print("s['videos'] ${s['videos']}");
      print("s['videos'] ${s['channels']}");
      List videoIds = s['videos'].map((video) => video.videoId).toList();
      String joinedVideoIds = "";
      for (var i = 0; i < videoIds.length; i++) {
        if ((i + 1) >= videoIds.length) {
          joinedVideoIds += videoIds[i];
        } else {
          joinedVideoIds += "${videoIds[i]},";
        }
      }
      print("joined video ids: $joinedVideoIds");
      //return ListView();
      return FutureBuilder(
          future: API.instance.getVideos(joinedVideoIds),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("has data");
              final List suggestions = snapshot.data as List;
              return ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  // print("video/channel: ${suggestions[index].title}");
                  /*if (suggestions[index].toString() != "Video") {
        return ListTile(
          leading: Icon(Icons.search),
          title: Text("${suggestions[index].title}"),
          trailing: Icon(Icons.arrow_upward),
        );
      } else {*/
                  return TryVideoCard(video: suggestions[index]);
                  //}
                },
              );
            } else {
              print("no data");
              return ListView();
            }
          });
    }
    return ListView();
  }

  Map s = {};
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: API.instance.searchF(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print("its in none");
              return ListView();
            case ConnectionState.active:
              print("oh so its in done");
              return ListView();
            case ConnectionState.waiting:
              print("connection aiting");
              return ListView();
            case ConnectionState.done:
              print("in done");
              final List suggestions = snapshot.data as List;
              s['channels'] = suggestions
                  .where((element) => element.toString() != "Video")
                  .toList();
              s['videos'] = suggestions
                  .where((element) => element.toString() == "Video")
                  .toList();
              print("videos: ${s['videos']}");
              return ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  print("video/channel: ${suggestions[index].title}");
                  return ListTile(
                    leading: Icon(Icons.search),
                    title: Text("${suggestions[index].title}"),
                    trailing: Icon(Icons.arrow_upward),
                  );
                },
              );
            default:
              print("In default");
              return ListView();
          }
          /*if (snapshot.hasData) {
            final List suggestions = snapshot.data as List;
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                print("video/channel: ${suggestions[index].title}");
                return ListTile(
                  leading: Icon(Icons.search),
                  title: Text("${suggestions[index].title}"),
                  trailing: Icon(Icons.arrow_upward),
                );
              },
            );
          } else {
            print("No data");
            return ListView();
          }*/
        },
      );
    } else {
      print("query empty");
      return ListView();
    }
  }
}
