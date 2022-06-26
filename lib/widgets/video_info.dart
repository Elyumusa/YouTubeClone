import 'package:flutter/material.dart';
import "package:timeago/timeago.dart" as timeago;
import 'package:youtube_clone/Models/channel_model.dart';
import 'package:youtube_clone/widgets/try_video_detail.dart';

import '../Logic/api.dart';
import '../Models/video_model.dart';
import '../data.dart' as data;

//import '../data.dart';

class VideoInfo extends StatefulWidget {
  final Video video;
  const VideoInfo({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  @override
  Widget build(BuildContext context) {
    final video = widget.video;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            " ${formatViewCount(video.viewCount!)} views • 12h ago",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
          ),
          _ActionsRow(),
          Divider(),
          _AuthorInfo(
            author: data.User(
                profileImageUrl: video.channelId,
                subscribers: formatViewCount('17300000'),
                username: video.channelTitle),
          ),
          Divider()
        ],
      ),
    );
  }
}

class _AuthorInfo extends StatelessWidget {
  final data.User author;
  const _AuthorInfo({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        print("Navigate to profile");
      }),
      child: Row(
        children: [
          FutureBuilder(
              future: API.instance.getChannel(author.profileImageUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final channel = snapshot.data as ChannelModel;
                  return CircleAvatar(
                      foregroundImage: NetworkImage(channel.thumbnailUrl));
                } else {
                  return CircleAvatar(
                    child: Icon(Icons.account_circle),
                  );
                }
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    author.username,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  )),
                  Flexible(
                    child: Text(
                      "${author.subscribers} subscribers",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "SUBSCRIBE",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActions(context, Icon(Icons.thumb_up_outlined), "500"),
        _buildActions(context, Icon(Icons.thumb_down_outlined), "200"),
        _buildActions(context, Icon(Icons.reply_outlined), "Share"),
        _buildActions(context, Icon(Icons.add_outlined), "Create"),
        _buildActions(context, Icon(Icons.cut_outlined), "Clip"),
        _buildActions(context, Icon(Icons.library_add_outlined), "Save"),
      ],
    );
  }

  _buildActions(BuildContext context, Icon icon, String s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          IconButton(onPressed: () {}, icon: icon),
          Text(
            s,
            style: Theme.of(context).textTheme.caption!,
          )
        ],
      ),
    );
  }
}
