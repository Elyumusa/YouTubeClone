import 'package:flutter/material.dart';
import 'package:youtube_clone/Logic/api.dart';

class CategoryPicker extends StatefulWidget {
  List<String> tabItems = [
    'Mr Beast',
    'MrBeast Gaming',
    'Beast Reacts',
    'MrBeast 2',
    'Beast Philanthropy'
  ];
  Function? whenTabChanges;
  CategoryPicker({
    this.whenTabChanges,
  });
  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late List<String> tabItems;
  int currentTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: widget.tabItems.length, vsync: this);
    controller.addListener(handleTabChanges);
    super.initState();
  }

  void handleTabChanges() {
    print('function called');
    String newvideoId = '';
    if (controller.indexIsChanging) return;
    print('function called: ${widget.tabItems[currentTab]}');
    setState(() {
      currentTab = controller.index;
    });
    switch (widget.tabItems[currentTab]) {
      case 'Mr Beast':
        widget.whenTabChanges!(API.instance.playlistId);
        break;
      case 'MrBeast Gaming':
        widget.whenTabChanges!(API.instance.beastGamingPlaylistID);
        break;
      case 'Beast Reacts':
        widget.whenTabChanges!(API.instance.beastReactPlaylistID);
        break;
      case 'MrBeast 2':
        widget.whenTabChanges!(API.instance.beast2PlaylistID);
        break;
      case 'Beast Philanthropy':
        widget.whenTabChanges!(API.instance.beastPhilanthropyPlaylistID);
        break;
    }
    print('function called: ${widget.tabItems[currentTab]}');
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (value) {
        handleTabChanges();
      },
      tabs: widget.tabItems
          .map((stringFromTab) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                      color: widget.tabItems[currentTab] == stringFromTab
                          ? Colors.grey[700]
                          : Colors.white),
                  child: Text(
                    stringFromTab,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      //fontSize: 18,
                      color: widget.tabItems[currentTab] == stringFromTab
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ))
          .toList(),
      indicatorColor: Colors.transparent,
      //labelColor: Colors.green,
      isScrollable: true,
      //unselectedLabelColor: Colors.transparent,
      controller: controller,
    );
  }
}
