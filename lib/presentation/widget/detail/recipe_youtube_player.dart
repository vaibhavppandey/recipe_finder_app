import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeYoutubePlayer extends StatefulWidget {
  final String youtubeUrl;

  const RecipeYoutubePlayer({super.key, required this.youtubeUrl});

  @override
  State<RecipeYoutubePlayer> createState() => _RecipeYoutubePlayerState();
}

class _RecipeYoutubePlayerState extends State<RecipeYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);

    if (videoId == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.videoTutorial,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        12.verticalSpace,
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ),
      ],
    );
  }
}
