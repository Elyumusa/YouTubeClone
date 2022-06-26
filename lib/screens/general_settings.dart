import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Logic/blocs/theme_bloc.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralState();
}

class _GeneralState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
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
                value: context.read<ThemeBloc>().currentlyDark,
                activeTrackColor: Colors.blue[900],
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.grey[300],
                onChanged: (currentState) {
                  setState(() {
                    if (context.read<ThemeBloc>().currentlyDark == true) {
                      context.read<ThemeBloc>().setTheme(ThemeMode.light);
                      context.read<ThemeBloc>().currentlyDark = false;
                    } else {
                      context.read<ThemeBloc>().setTheme(ThemeMode.dark);
                      context.read<ThemeBloc>().currentlyDark = true;
                    }
                  });
                })
          ],
        )
      ]),
    );
  }
}
