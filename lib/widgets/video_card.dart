/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/Logic/blocs/bloc.dart';
import 'package:youtube_clone/data.dart';
import "package:timeago/timeago.dart" as timeago;
import 'package:youtube_clone/widgets/video_details.dart';

class VideoCard extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;
  const VideoCard({Key? key, required this.video, this.onTap})
      : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    Video video = widget.video;
    return GestureDetector(
      onTap: () {
        print("Video tapped");
        context.read<CurrentVideoBloc>().add(ChangeVideoEvent(video: video));
        context
            .read<CurrentVideoBloc>()
            .miniplayerController
            .animateToHeight(state: PanelState.MAX);
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
                    video.duration,
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
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      foregroundImage:
                          NetworkImage(video.author.profileImageUrl),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                VideoDetails(video: video),
                GestureDetector(onTap: () {}, child: Icon(Icons.more_vert))
              ],
            ),
          )
        ],
      ),
    );
  }
}*/
