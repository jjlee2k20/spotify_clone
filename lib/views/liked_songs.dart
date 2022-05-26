import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/constants/liked_songs.dart';
import 'package:spotify_clone/constants/palette.dart';
import 'package:spotify_clone/controllers/song_controller.dart';
import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/widgets/currently_playing_song.dart';
import 'package:spotify_clone/widgets/shrink_feedback.dart';
import 'package:spotify_clone/widgets/song_tile.dart';

class LikedSongsView extends StatefulWidget {
  const LikedSongsView({Key? key}) : super(key: key);

  @override
  State<LikedSongsView> createState() => _LikedSongsViewState();
}

class _LikedSongsViewState extends State<LikedSongsView> {
  final _scrollController = ScrollController();
  // feels kind of hacky idk
  double _appBarOpacity = 0;
  double _appBarTextOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset < 40) {
          _appBarOpacity = 0;
          _appBarTextOpacity = 0;
        } else {
          _appBarOpacity = min((_scrollController.offset - 40) / 10, 1);
          _appBarTextOpacity = min((_scrollController.offset - 40) / 60, 1);
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<SongController>().selectPlaylist(likedSongs, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // first section: building the main listview
    return GetBuilder<SongController>(builder: (controller) {
      final currentSong = controller.currentSong;
      return Scaffold(
        appBar: _buildAppBar(),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ShrinkFeedback(
                    // wrap with material to make entire tile clickable
                    child: Material(
                      color: Colors.transparent,
                      child: SongTile(
                        song: likedSongs[i],
                        isSelected: likedSongs[i] == currentSong,
                      ),
                    ),
                    onPressed: () {
                      Get.find<SongController>().selectSong(i);
                    },
                  ),
                  childCount: likedSongs.length,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: currentSong == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(8),
                child: SafeArea(
                  child: CurrentlyPlayingSong(
                    song: currentSong,
                    position: controller.position / controller.totalDuration,
                    isPlaying: controller.isPlaying,
                    playOrPause: controller.playOrPause,
                  ),
                ),
              ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar() => PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF293360).withOpacity(_appBarOpacity),
                Color(0xFF212740).withOpacity(_appBarOpacity),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  SizedBox(width: 28),
                  Text(
                    'Liked Songs',
                    style: TextStyle(
                      color: Colors.white.withOpacity(_appBarTextOpacity),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Liked Songs',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '166 songs',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildEnhanceButton(),
                    ],
                  ),
                ),
                _buildPlayShuffleButton(),
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

  Widget _buildPlayShuffleButton() => Stack(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Palette.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Icon(Icons.play_arrow, size: 32),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.shuffle,
                  color: Palette.green,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      );
}
