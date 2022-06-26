import 'package:flutter/material.dart';
import 'package:youtube_clone/data.dart';
import "package:timeago/timeago.dart" as timeago;

class VideoDetails extends StatelessWidget {
  const VideoDetails({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Text(
            video.title,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
          Flexible(
            child: Text(
              "${video.author.username} • ${video.viewCount} views • ${timeago.format(video.timestamp)}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
