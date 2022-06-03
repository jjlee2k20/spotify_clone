import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/opacity_feedback.dart';

class SongView extends StatefulWidget {
  final Song song;

  const SongView({Key? key, required this.song}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  bool _isPlaying = false;
  int _position = 0; // in seconds
  int _totalDuration = 1;

  AudioPlayer? _player;
  AudioCache? _cache;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((duration) {
      setState(() => _totalDuration = duration.inSeconds);
    });
    _player!.onAudioPositionChanged.listen((newPosition) {
      setState(() => _position = newPosition.inSeconds);
    });
  }

  @override
  void dispose() {
    _player!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF775c5c),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          child: _mainUi(context),
        ),
      ),
    );
  }

  Widget _mainUi(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _buildTop(context),
        SizedBox(height: 70),
        Image.asset(
          widget.song.coverImage,
          width: screenWidth - 48,
          height: screenWidth - 48,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildSongDetails(),
              SizedBox(height: 28),
              _buildPositionIndicator(),
              SizedBox(height: 2),
              _buildDurationTexts(),
              SizedBox(height: 8),
              _buildActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTop(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Row(
          children: [
            OpacityFeedback(
              onPressed: Navigator.of(context).pop,
              child: Icon(Icons.keyboard_arrow_down, size: 30),
            ),
            Expanded(
              child: Column(
                children: [
                  styledText(
                    'PLAYING FROM YOUR LIBRARY',
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                  SizedBox(height: 2),
                  styledText(
                    'Liked Songs',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            Icon(Icons.more_vert),
          ],
        ),
      );

  Widget _buildSongDetails() => Row(
        children: [
          expandedColumnStart([
            styledText(
              widget.song.title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              oneLineEllipsis: true,
            ),
            styledText(
              widget.song.artistName,
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
              oneLineEllipsis: true,
            ),
          ]),
          SizedBox(width: 16),
          Icon(
            widget.song.liked ? Icons.favorite : Icons.favorite_border,
            color: widget.song.liked ? Palette.green : Colors.white,
            size: 24,
          ),
        ],
      );

  Widget _buildPositionIndicator() => FractionallySizedBox(
        widthFactor: 1.04,
        child: SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            trackShape: CustomTrackShape(),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            trackHeight: 4,
          ),
          child: Slider(
            min: 0,
            max: _totalDuration.toDouble(),
            value: _position.toDouble(),
            onChanged: (value) {
              _seek(value.toInt());
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.1),
          ),
        ),
      );

  Widget _buildDurationTexts() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDuration(_position),
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Text(
            formatDuration(_totalDuration),
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      );

  Widget _buildActions() => Row(
        children: [
          Icon(Icons.shuffle, size: 24),
          Spacer(flex: 3),
          Icon(Icons.skip_previous, size: 36),
          Spacer(flex: 2),
          OpacityFeedback(
            onPressed: _playOrPause,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                  size: 36,
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
          Icon(Icons.skip_next, size: 36),
          Spacer(flex: 3),
          Icon(Icons.loop, size: 24),
        ],
      );

  void _playOrPause() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _cache!.play(widget.song.mp3Path);
    } else {
      _player!.pause();
    }
  }

  _seek(int to) => _player!.seek(Duration(seconds: to));
}

String formatDuration(int duration) {
  final seconds = (duration % 60).toString().padLeft(2, '0');
  return '${duration ~/ 60}:$seconds';
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 2}) {
    super.paint(context, offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        isDiscrete: isDiscrete,
        isEnabled: isEnabled,
        additionalActiveTrackHeight: 0);
  }
}
