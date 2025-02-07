import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

sealed class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoLoading extends VideoPlayerState {}

class VideoReady extends VideoPlayerState {
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;
  VideoReady({
    required this.videoPlayerController,
    required this.chewieController,
  });
}

class VideoError extends VideoPlayerState {
  final String errorMessage;

  VideoError(this.errorMessage);
}
