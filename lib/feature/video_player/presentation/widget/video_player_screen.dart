import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/video_player/presentation/cubit/video_player_cubit.dart';
import 'package:lms/feature/video_player/presentation/cubit/video_player_state.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerCubit()..initializeVideo(url),
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoReady) {
            return Chewie(controller: state.chewieController);
          } else if (state is VideoError) {
            return Center(
                child: Text(
              state.errorMessage,
              style: const TextStyle(
                fontSize: 12,
              ),
            ));
          } else {
            return const Center(child: Text("Initializing video..."));
          }
        },
      ),
    );
  }
}

void showVideoDialog(String url, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: 0.4.h(context),
          child: VideoPlayerScreen(url: url),
        ),
      );
    },
  );
}
