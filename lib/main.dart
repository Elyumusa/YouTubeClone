import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/Logic/blocs/bloc.dart';
import 'package:youtube_clone/screens/nav_screen.dart';
import 'package:youtube_clone/themes/themes.dart';

import 'Logic/blocs/theme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentVideoBloc(null),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        )
      ],
      child: YouTubeClone(),
    );
  }
}

class YouTubeClone extends StatelessWidget {
  const YouTubeClone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter YouTube UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.select((ThemeBloc bloc) => bloc.state),
      home: NavScreen(),
    );
  }
}
