import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/screens/general_settings.dart';

import '../Logic/blocs/theme_bloc.dart';
import '../data.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

List settingsItems1 = ["Your channel", "Turn on Incognito", "Add Account"];
List settingsItems2 = [
  "Get YouTube Premium",
  "Purchases and memberships",
  "Time watched",
  "Your data in YouTube"
];
List settingsItems3 = ["Settings", "Help & feedback"];
List settingsItems4 = ["YouTube Studio", "YouTube Music", "YouTube Kids"];

class _AccountPageState extends State<AccountPage> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(children: [
        SizedBox(
          height: 110,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      foregroundImage:
                          NetworkImage(currentUser.profileImageUrl),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text("elyumusa njobvu"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Manage your Google Account",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ...List.generate(settingsItems1.length, (index) {
          return showMenuItem(settingsItems1[index], () {
            if (settingsItems1[index] == "Your channel") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneralSettings(),
                  ));
            }
          });
        }),
        Divider(),
        ...List.generate(
            settingsItems2.length,
            (index) => showMenuItem(
                  settingsItems2[index],
                  (() {}),
                )),
        Divider(),
        ...List.generate(
          settingsItems3.length,
          (index) => showMenuItem(settingsItems3[index], () {}),
        ),
        Divider(),
        ...List.generate(
          settingsItems4.length,
          (index) => showMenuItem(settingsItems4[index], () {}),
        ),
        /* Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dark theme"),
                Text("Reduce glare & improve night viewing")
              ],
            ),
            Spacer(),
            Switch(
                value: darkMode,
                activeTrackColor: Colors.blue[900],
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.grey[300],
                onChanged: (currentState) {
                  setState(() {
                    if (darkMode == true) {
                      context.read<ThemeBloc>().setTheme(ThemeMode.light);
                      darkMode = false;
                    } else {
                      context.read<ThemeBloc>().setTheme(ThemeMode.dark);
                      darkMode = true;
                    }
                  });
                })
          ],
        )*/
      ]),
    );
  }

  Padding showMenuItem(String title, void Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 10,
        leading: Icon(
          Icons.account_box_outlined,
          size: 35,
        ),
        title: Text(title),
      ),
    );
  }
}
