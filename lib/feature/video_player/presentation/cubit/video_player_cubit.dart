import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/video_player/presentation/cubit/video_player_state.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  void initializeVideo(String url) async {
    emit(VideoLoading());
    try {
      final token = await SharedUtility.getToken();
      final videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(UrlConstant.video(url)),
          httpHeaders: {
            "Authorization": "Bearer $token",
          });
      await videoPlayerController.initialize();
      await videoPlayerController.initialize();
      final chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: false,
          showControls: true);
      emit(VideoReady(
          videoPlayerController: videoPlayerController,
          chewieController: chewieController));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    if (state is VideoReady) {
      final videoReady = state as VideoReady;
      videoReady.videoPlayerController.dispose();
      videoReady.chewieController.dispose();
    }
    return super.close();
  }
}
