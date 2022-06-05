import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/library.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/utils/common_widgets.dart';
import 'package:spotify_clone/widgets/currently_playing_song.dart';
import 'package:spotify_clone/widgets/play_shuffle_button.dart';
import 'package:spotify_clone/widgets/shrink_feedback.dart';
import 'package:spotify_clone/widgets/song_tile.dart';

class LikedSongsView extends StatefulWidget {
  const LikedSongsView({Key? key}) : super(key: key);

  @override
  State<LikedSongsView> createState() => _LikedSongsViewState();
}

class _LikedSongsViewState extends State<LikedSongsView> {
  Song? _currentSong;

  @override
  Widget build(BuildContext context) {
    // first section: building the main listview
    return Scaffold(
      body: _buildMainScrollView(),
      bottomNavigationBar: _currentSong == null
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CurrentlyPlayingSong(
                  song: _currentSong!,
                  position: 0.4,
                  isPlaying: false,
                  playOrPause: () {},
                ),
              ),
            ),
    );
  }

  Widget _buildMainScrollView() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: likedSongs.length,
            itemBuilder: (context, i) => ShrinkFeedback(
              // wrap with material to make entire tile clickable
              child: Material(
                color: Colors.transparent,
                child: SongTile(
                  song: likedSongs[i],
                  isSelected: likedSongs[i] == _currentSong,
                ),
              ),
              onPressed: () {
                setState(() => _currentSong = likedSongs[i]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2a41a9),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          // kind of a weird setup
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                expandedColumnStart([
                  styledText(
                    'Liked Songs',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 8),
                  styledText(
                    '${likedSongs.length} songs',
                    color: Colors.white.withOpacity(0.6),
                  ),
                  SizedBox(height: 8),
                  _buildEnhanceButton(),
                ]),
                PlayShuffleButton(),
              ],
            ),
          ),
        ),
      );

  Widget _buildEnhanceButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'Enhance',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      );
}
