import 'package:flutter/material.dart';
//import 'package:youtube_clone/data.dart';
import "package:timeago/timeago.dart" as timeago;

import '../Models/video_model.dart';

class TryVideoDetails extends StatelessWidget {
  const TryVideoDetails({
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
              "${video.channelTitle} • ${video.viewCount != null ? formatViewCount(video.viewCount!) : '7.5M'} views ",
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

String formatViewCount(String viewCount) {
  print("in format vie count");
  String formattedString = "";
  switch (viewCount.length) {
    case 9:
      formattedString = "${viewCount.substring(0, 3)}M";
      break;
    case 8:
      formattedString = "${viewCount.substring(0, 2)}M";
      break;
    case 7:
      String temp = int.parse(viewCount.substring(0, 2)).toStringAsFixed(1);
      temp.split('.')[0].split('').join('.');
      formattedString = "${temp.split('.')[0].split('').join('.')}M";
      break;
    case 6:
      formattedString = "${viewCount.substring(0, 3)}K";
      break;
    case 5:
      formattedString = viewCount.substring(0, 2);
      break;
    case 4:
      formattedString = "${int.parse(viewCount).toStringAsFixed(1)}K";
      break;
    default:
      print("It on default");
      formattedString = viewCount;
  }
  print("finished in vie count");
  return formattedString;
}
