import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/Logic/api.dart';
import 'package:youtube_clone/Logic/blocs/bloc.dart';
import 'package:youtube_clone/Models/channel_model.dart';
import 'package:youtube_clone/data.dart' as data;
import "package:timeago/timeago.dart" as timeago;
import 'package:youtube_clone/widgets/try_video_detail.dart';
import 'package:youtube_clone/widgets/video_details.dart';

import '../Models/video_model.dart';

class TryVideoCard extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;
  const TryVideoCard({Key? key, required this.video, this.onTap})
      : super(key: key);

  @override
  State<TryVideoCard> createState() => _TryVideoCardState();
}

class _TryVideoCardState extends State<TryVideoCard> {
  @override
  Widget build(BuildContext context) {
    Video video = widget.video;
    return GestureDetector(
      onTap: () {
        print("Video tapped");
        context.read<CurrentVideoBloc>().add(ChangeVideoEvent(video: video));
        /*context
            .read<CurrentVideoBloc>()
            .miniplayerController
            .animateToHeight(state: PanelState.MAX);*/
        if (widget.onTap != null) widget.onTap!();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(video.thumbnailUrl,
                  height: 220.0, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.black,
                  child: Text(
                    video.duration != null
                        ? formatDuration(video.duration!)
                        : '8:45',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                ),
                bottom: 0,
                right: 8,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FutureBuilder(
                      future: API.instance.getChannel(video.channelId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          video.channel = snapshot.data as ChannelModel;
                          return GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              foregroundImage:
                                  NetworkImage(video.channel!.thumbnailUrl),
                            ),
                          );
                        } else {
                          print('no data in channel ection !');
                          return GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              child: Icon(Icons.account_circle),
                            ),
                          );
                        }
                      }),
                ),
                const SizedBox(
                  height: 9,
                ),
                TryVideoDetails(video: video),
                GestureDetector(onTap: () {}, child: Icon(Icons.more_vert))
              ],
            ),
          )
        ],
      ),
    );
  }
}

String formatDuration(String duration) {
  print("in formated duration");
  String formattedDuration = "";
  List indi = duration.split("M");
  List secsList = indi[1].toString().split("");
  List hrsList = indi[0].toString().split("");
  List hrs = [];
  List secs = [];
  List formatedtime = [];
  for (var i = 0; i < hrsList.length; i++) {
    if (int.tryParse(hrsList[i]) != null) {
      hrs.add(hrsList[i]);
    }
  }
  for (var i = 0; i < secsList.length; i++) {
    if (secsList.length < 3) {
      if (int.tryParse(secsList[i]) != null) {
        secs.add("0${secsList[i]}");
      }
    } else {
      if (int.tryParse(secsList[i]) != null) {
        secs.add(secsList[i]);
      }
    }
  }
  formatedtime.add(hrs.join());
  formatedtime.add(secs.join());
  formattedDuration = formatedtime.join(':');
  print("finished in formated duration");
  return formattedDuration;
}
