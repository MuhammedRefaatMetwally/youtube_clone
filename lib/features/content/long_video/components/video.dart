import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import '../model/video_model.dart';
import '../widgets/channel_info.dart';
import '../widgets/comment_section.dart';
import '../widgets/related_videos.dart';
import '../widgets/video_actions.dart';
import '../widgets/video_details.dart';
import '../widgets/video_player_widget.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;

  const Video({Key? key, required this.video}) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  bool isShowIcons = false;
  bool isPlaying = false;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            setState(() {
              isPlaying = _controller!.value.isPlaying;
            });
          }).catchError((error) {
            // Handle initialization errors here
            print("Error initializing video player: $error");
          });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user =
        ref.watch(anyUserDataProvider(widget.video.userId));

    final screenSize = MediaQuery.of(context).size;
    final videoHeight = screenSize.width * 9 / 16; // 16:9 aspect ratio
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(videoHeight),
          child: VideoPlayerWidget(
            controller: _controller,
            isShowIcons: isShowIcons,
            isPlaying: isPlaying,
            onToggleIcons: () {
              setState(() {
                isShowIcons = !isShowIcons;
              });
            },
            onTogglePlayPause: toggleVideoPlayer,
            onGoForward: goForward,
            onGoBackward: goBackward,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoDetails(video: widget.video),
              ChannelInfo(video: widget.video, user: user, ref: ref),
              VideoActions(video: widget.video, ref: ref),
              CommentSection(video: widget.video, user: user, ref: ref),
              RelatedVideos(video: widget.video),
            ],
          ),
        ),
      ),
    );
  }

  void toggleVideoPlayer() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
      isPlaying = false;
    } else {
      _controller!.play();
      isPlaying = true;
    }
    setState(() {});
  }

  void goBackward() {
    Duration position =
        _controller!.value.position - const Duration(seconds: 10);
    _controller!.seekTo(position);
  }

  void goForward() {
    Duration position =
        _controller!.value.position + const Duration(seconds: 10);
    _controller!.seekTo(position);
  }
}
