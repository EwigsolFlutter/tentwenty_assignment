import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/model/apis/api_response.dart';
import 'package:tentwenty_assignment/view_model/media_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerFirstScreen extends StatelessWidget {
  final String id;
  const PlayerFirstScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    String mediaList = apiResponse.data.toString();
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return PlayerScreen(id: mediaList);
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse =
        Provider.of<MediaViewModel>(context).responseVIDEO;
    return Scaffold(
      body: getMediaWidget(context, apiResponse),
    );
  }
}

/// Homepage
class PlayerScreen extends StatefulWidget {
  final String id;
  const PlayerScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late YoutubePlayerController _controller;
  // late TextEditingController _idController;
  // late TextEditingController _seekToController;

  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  // final double _volume = 100;
  // final bool _muted = false;
  final bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    print("object : " + widget.id);
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        useHybridComposition: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    // if(_controller.)
    // if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
    //   setState(() {
    //     // _playerState = _controller.value.playerState;
    //     // _videoMetaData = _controller.metadata;
    //   });
    // }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              onEnded: (c) {
                Navigator.pop(context);
              },
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(listener);
              },
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Done'))
        ],
      ),
    );
  }
}
