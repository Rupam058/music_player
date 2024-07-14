import 'package:flutter/material.dart';
import 'package:minimal_music_player/models/songs.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    // song 1
    Song(
      songName: 'Iko Iko',
      artistName: 'Justin Wellington',
      albumArtImagePath: 'assets/images/1.jpg',
      audioPath: 'songs/1.mp3',
    ),

    // song 2
    Song(
      songName: 'Lazarus',
      artistName: 'Porcupine Tree',
      albumArtImagePath: 'assets/images/2.jpg',
      audioPath: 'songs/2.mp3',
    )
  ];

  // current song playing index
  int? _currentSongIndex;

  // -------- CODING UP THE AUDIO PLAYER

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() {
    // if more than 2 sec have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if value within 2 sec, go to the previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if it's the first song, loop back to last
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPostion) {
      _currentDuration = newPostion;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose of the audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // ----------- CODING UP THE AUDIO PLAYER

  // get playlist
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // set current song playing index
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at the new index
    }

    // update UI
    notifyListeners();
  }
}
