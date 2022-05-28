import 'package:spotify_clone/models/song.dart';
import 'package:spotify_clone/models/playlist.dart';

final likedSongs = [
  Song(
    coverImage: 'assets/images/nine_track_mind.png',
    title: 'Marvin Gaye (feat. Meghan Trainor)',
    artistName: 'Charlie Puth, Meghan Trainor',
    tags: ['Lyrics', 'E'],
    mp3Path: 'songs/marvin_gaye.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/fearless.jpeg',
    title: 'The Best Day (Taylor\'s Version)',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/the_best_day.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/red_taylors_version.png',
    title: 'Starlight (Taylor\'s Version)',
    artistName: 'Taylor Swift',
    tags: [],
    mp3Path: 'songs/starlight.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/speak_now.png',
    title: 'Mine',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/mine.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/speak_now.png',
    title: 'Long Live',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/long_live.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/red.jpeg',
    title: 'All Too Well',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/all_too_well.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/monster.jpeg',
    title: '怪物',
    artistName: 'YOASOBI',
    tags: [],
    mp3Path: 'songs/monster.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/red_taylors_version.png',
    title: 'Message In A Bottle (Taylor\'s Version)',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/message_in_a_bottle.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/red.jpeg',
    title: 'The Lucky One',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/the_lucky_one.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/speak_now.png',
    title: 'Ours',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/ours.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'London Boy',
    artistName: 'Taylor Swift',
    tags: [],
    mp3Path: 'songs/london_boy.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'Lover',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/lover.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'I Think He Knows',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/i_think_he_knows.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'Paper Rings',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/paper_rings.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'You Need To Calm Down',
    artistName: 'Taylor Swift',
    tags: ['Lyrics'],
    mp3Path: 'songs/you_need_to_calm_down.mp3',
    liked: true,
  ),
  Song(
    coverImage: 'assets/images/lover.jpeg',
    title: 'ME! (feat. Brendon Urie of Panic! At The Disco)',
    artistName: 'Taylor Swift, Brendon Urie, Panic! At The Disco',
    tags: ['Lyrics'],
    mp3Path: 'songs/me.mp3',
    liked: true,
  ),
];

final library = [
  Playlist(
    title: 'Liked Songs',
    coverImage: 'assets/images/liked_songs.png',
    ownerName: 'mkofdwu',
    isAlbum: false,
    isPinned: true,
    songs: likedSongs,
  ),
  Playlist(
    title:
        'Interstellar (Original Motion Picture Soundtrack) [Expanded Edition]',
    coverImage: 'assets/images/interstellar.jpeg',
    ownerName: 'Hans Zimmer',
    isAlbum: true,
    isPinned: false,
    albumReleaseDate: DateTime(2014, 11, 18),
    songs: [
          'Dreaming of the Crash',
          'Cornfield Chase',
          'Dust',
          'Day One',
          'Stay',
          'Message from Home',
          'The Wormhole',
          'Mountains',
          'Afraid of Time',
          'A Place Among the Stars',
          'Running Out',
          'I\'m Going Home',
          'Coward',
          'Detach',
          'S.T.A.Y',
          'Where We\'re Going',
          'First Step',
          'Flying Drone',
          'Atmospheric Entry',
          'No Need to Come Back',
          'Imperfect Lock',
          'No Time for Caution',
          'What Happens Now?',
          'Who\'s They?',
          'Murph',
          'Organ Variation',
          'Tick-Tock',
          'Day One - Original Demo',
          'Day One Dark'
        ]
            .map((title) => Song(
                  title: title,
                  artistName: 'Hans Zimmer',
                  coverImage: 'assets/images/interstellar.jpeg',
                  tags: [],
                  mp3Path: '',
                  liked: false,
                ))
            .toList() +
        [
          Song(
            title: 'Do Not Go Gentle Into That Good Night',
            artistName:
                'Hans Zimmer, John Lithgow, Ellen Burstyn, Casey Affleck, Jessica Chastain, Matthew McConaughey, Mackenzie Foy',
            coverImage: 'assets/images/interstellar.jpeg',
            tags: [],
            mp3Path: '',
            liked: false,
          )
        ],
  ),
];
