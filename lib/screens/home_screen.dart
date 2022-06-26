import 'package:flutter/material.dart';
import 'package:youtube_clone/widgets/category_picker.dart';
import "package:youtube_clone/widgets/idgets.dart";

import '../Logic/api.dart';
import '../Models/channel_model.dart';
import '../Models/video_model.dart';
import '../widgets/tryVideoCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String videosShowingID = API.instance.playlistId;
  bool _isLoading = false;
  _loadMoreVideos() async {
    _isLoading = true;
    List moreVideos = await API.instance
        .fetchVideosFromPlaylist(playlist_id: videosShowingID);
    setState(() {
      videos.addAll(moreVideos);
    });
    _isLoading = false;
  }

  ChannelModel? vidChannel;
  getChannel(String channelId) async {
    final channel = await API.instance.getChannel(channelId);
    vidChannel = channel;
  }

  static List videos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: ((notification) {
          if (!_isLoading &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            print("reached the end");
            _loadMoreVideos();
          }
          return _isLoading;
        }),
        child: CustomScrollView(
          slivers: [
            mySliverappBar(context),
            /*SliverPadding(
              padding: const EdgeInsets.only(bottom: 60.0),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final video = videos[index];
                return VideoCard(video: video);
              }, childCount: videos.length)),
            )*/
            SliverToBoxAdapter(
              child: CategoryPicker(whenTabChanges: (String newvideoId) {
                setState(() {
                  videosShowingID = newvideoId;
                  videos = [];
                });
              }),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                  future: API.instance
                      .fetchVideosFromPlaylist(playlist_id: videosShowingID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("has data");
                      List videoIds = snapshot.data as List;
                      videoIds = videoIds.map(((video) {
                        Video v = video as Video;
                        return v.videoId;
                      })).toList();
                      return FutureBuilder(
                          future: API.instance.getVideos(videoIds.join(',')),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print("has data");
                              List vids = snapshot.data as List;
                              if (videos.isNotEmpty) vids.addAll(videos);
                              return Column(
                                children: [
                                  ...List.generate(
                                    vids.length,
                                    (index) {
                                      //getChannel(vids[index].channelId);
                                      //print("videoChannel: $vidChannel");
                                      // vids[index].channel = vidChannel;
                                      return TryVideoCard(video: vids[index]);
                                      //}
                                    },
                                  ),
                                ],
                              );
                            } else {
                              print("no data");
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                              //return ListView();
                            }
                          });
                    } else {
                      print("no data");
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                      //return ListView();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
