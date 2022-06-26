import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../Models/video_model.dart';
//import 'package:youtube_clone/data.dart';

class CurrentVideoBloc extends Bloc<ChangeVideoEvent, Video?> {
  final Video? initialVideo;
  late MiniplayerController miniplayerController;
  CurrentVideoBloc(this.initialVideo) : super(initialVideo) {
    miniplayerController = MiniplayerController();
    on<ChangeVideoEvent>((event, emit) => emit(event.video));
  }
  void dispose() {
    miniplayerController.dispose();
  }
}

class ChangeVideoEvent {
  Video? video;
  ChangeVideoEvent({required this.video});
}
