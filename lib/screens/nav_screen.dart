// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/screens/home_screen.dart';
import 'package:youtube_clone/screens/video_screen/video_screen.dart';
import 'package:youtube_clone/widgets/video_details.dart';

import '../Logic/blocs/bloc.dart';
import '../Models/video_model.dart';
//import '../data.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavState();
}

class _NavState extends State<NavScreen> {
  static const double _playerMinHeight = 60.0;
  final _screens = [
    HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text("Shorts"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Add"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Subscriptions"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Library"),
      ),
    ),
  ];
  int selectedIndex = 0;
  late MiniplayerController miniplayerController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    miniplayerController.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    miniplayerController =
        BlocProvider.of<CurrentVideoBloc>(context).miniplayerController;
  }

  @override
  Widget build(BuildContext context) {
    final selectedVideo = context.watch<CurrentVideoBloc>().state;
    return Scaffold(
      body: BlocConsumer<CurrentVideoBloc, Video?>(
        listener: (context, state) {
          // TODO: implement listener
          //print("current video: ${state!.title}");
        },
        builder: (context, state) {
          return Stack(
            children: [
              ..._screens
                  .asMap()
                  .map((i, screen) => MapEntry(
                      i,
                      Offstage(
                        offstage: selectedIndex != i,
                        child: screen,
                      )))
                  .values
                  .toList(),
              Offstage(
                offstage: selectedVideo == null,
                child: Miniplayer(
                    controller: miniplayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (selectedVideo == null) {
                        return SizedBox.shrink();
                      }
                      if (height <= _playerMinHeight + 50.0) {
                        return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(children: [
                            Row(
                              children: [
                                Image.network(
                                  selectedVideo.thumbnailUrl,
                                  height: _playerMinHeight - 4.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          selectedVideo.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  //color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        Flexible(
                                          child: Text(
                                            "${selectedVideo.channelTitle}",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.play_arrow)),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<CurrentVideoBloc>()
                                          .add(ChangeVideoEvent(video: null));
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                          ]),
                        );
                      }
                      //puhVideocreen(context);
                      return VideoScreen();
                    }),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          onTap: (current_i) {
            setState(() {
              selectedIndex = current_i;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                activeIcon: Icon(Icons.explore_outlined),
                label: "Shorts"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions_outlined),
                activeIcon: Icon(Icons.subscriptions),
                label: "Subscriptions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined),
                activeIcon: Icon(Icons.video_library),
                label: "Library"),
          ]),
    );
  }

  void puhVideocreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoScreen(),
        ));
  }
}
