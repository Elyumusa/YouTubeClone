import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/screens/account_crren.dart';

import '../screens/earch_delegate.dart';

SliverAppBar mySliverappBar(BuildContext context) {
  return SliverAppBar(
    floating: true,
    leadingWidth: 100.0,
    actions: [
      IconButton(
          onPressed: (() {}),
          icon: Icon(
            Icons.cast,
            color: Theme.of(context).iconTheme.color,
          )),
      IconButton(
          onPressed: (() {}),
          icon: SvgPicture.asset(
            "assets/notification-svgrepo-com.svg",
            height: 22,
            width: 22,
          ) /* Icon(Icons.notifications_outlined,
              color: Theme.of(context).iconTheme.color)*/
          ),
      IconButton(
          onPressed: (() {
            showSearch(context: context, delegate: SearchD());
          }),
          icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color)),
      IconButton(
          iconSize: 20.0,
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AccountPage())));
          }),
          icon: CircleAvatar(
            child: Icon(Icons.account_circle),
          )),
    ],
    leading: Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Image.asset(
        "assets/yt_logo_rgb_light.png",
        scale: 2,
        height: 80,
        width: 100,
        //fit: BoxFit.contain,
      ),
    ),
  );
}
