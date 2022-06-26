import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/Logic/blocs/bloc.dart';
import 'package:youtube_clone/screens/home_screen.dart';
import 'package:youtube_clone/widgets/idgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Logic/api.dart';
import '../../Models/channel_model.dart';
import '../../Models/video_model.dart';
import '../../widgets/tryVideoCard.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  List vidsUnder = HomeScreenState.videos;
  late YoutubePlayerController _controller;
  _loadMoreVideos() async {
    _isLoading = true;
    List moreVideos = await API.instance
        .fetchVideosFromPlaylist(playlist_id: API.instance.playlistId);
    moreVideos = moreVideos.map(((video) {
      Video v = video as Video;
      return v.videoId;
    })).toList();
    moreVideos = await API.instance.getVideos(moreVideos.join(','));
    setState(() {
      vidsUnder.addAll(moreVideos);
    });
    _isLoading = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('vidsUnder $vidsUnder');
    _controller = YoutubePlayerController(
        initialVideoId:
            BlocProvider.of<CurrentVideoBloc>(context).state!.videoId,
        flags: YoutubePlayerFlags(mute: false, autoPlay: false));
    _scrollController = ScrollController();
  }

  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController!.dispose();
    super.dispose();
  }

  ChannelModel? vidChannel;
  getChannel(String channelId) async {
    final channel = await API.instance.getChannel(channelId);
    vidChannel = channel;
  }

  @override
  Widget build(BuildContext context) {
    final selectedVideo = context.watch<CurrentVideoBloc>().state;

    _controller = YoutubePlayerController(
        initialVideoId: selectedVideo!.videoId,
        flags: YoutubePlayerFlags(mute: false, autoPlay: false));

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: ((notification) {
              if (!_isLoading &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                print("reached the end");
                _loadMoreVideos();
              }
              return _isLoading;
            }),
            child: ListView(
              controller: _scrollController,
              children: [
                SizedBox(
                  height: 250,
                ),
                VideoInfo(video: selectedVideo),
                InkResponse(
                  onTap: (() {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height - 200,
                            minHeight:
                                MediaQuery.of(context).size.height - 200),
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Stack(
                              children: [],
                            ),
                          );
                        });
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Comments"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('424'),
                                Spacer(),
                                Image.asset(
                                  "assets/up-and-down-arrow.png",
                                  height: 25,
                                  width: 25,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    // size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Never heard of him, as a non-millionare",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                ...List.generate(
                  vidsUnder.length,
                  (index) {
                    print("videos from home screen");
                    final video = vidsUnder[index];
                    getChannel(video.channelId);
                    print("videoChannel: $vidChannel");
                    video.channel = vidChannel;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TryVideoCard(
                        video: video,
                        onTap: () {
                          setState(() {
                            _scrollController!.animateTo(0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Stack(
            children: [
              GestureDetector(
                onVerticalDragDown: (details) {
                  return context
                      .read<CurrentVideoBloc>()
                      .miniplayerController
                      .animateToHeight(state: PanelState.MIN);
                },
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print("player ready");
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  return context
                      .read<CurrentVideoBloc>()
                      .miniplayerController
                      .animateToHeight(state: PanelState.MIN);
                },
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 30.0,
              )
            ],
          ),
        ],
      ),
    ) /*Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          selectedVideo!.thumbnailUrl,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          onPressed: () {
                            return context
                                .read<CurrentVideoBloc>()
                                .miniplayerController
                                .animateToHeight(state: PanelState.MIN);
                          },
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30.0,
                        )
                      ],
                    ),
                    LinearProgressIndicator(
                      value: 0.4,
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                    VideoInfo(video: selectedVideo)
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkResponse(
                onTap: (() {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height - 200,
                          minHeight:
                              MediaQuery.of(context).size.height - 200),
                      builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: Stack(
                            children: [],
                          ),
                        );
                      });
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("Comments"),
                              SizedBox(
                                width: 10,
                              ),
                              Text('424'),
                              Spacer(),
                              Icon(Icons.arrow_downward)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  // size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Never heard of him, as a non-millionare",
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            /* SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              final video = suggestedVideos[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: VideoCard(
                  video: video,
                  onTap: () {
                    _scrollController!.animateTo(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                ),
              );
            }, childCount: suggestedVideos.length))
          */
          ],
        ),
      ),
    */
        );
  }
}
