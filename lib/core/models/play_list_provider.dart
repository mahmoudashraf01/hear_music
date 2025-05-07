import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hear_music/core/models/song_model.dart';

class PlayListProvider extends ChangeNotifier {
  final List<SongModel> _playList = [
    SongModel(
      songName: 'Stcuk On You',
      artistName: 'Lionel Richie',
      albumImgPath: 'assets/images/stack_on_you.jpg',
      audioPath: 'audio/STUCK_ON _YOU.mp3',
    ),
    SongModel(
      songName: 'Gone Gone Gone',
      artistName: 'Phillip Phillips',
      albumImgPath: 'assets/images/gone_gone_gone.jpg',
      audioPath: 'audio/Gone_Gone_Gone.mp3',
    ),
    SongModel(
      songName: 'If You Love Her',
      artistName: 'Forest Blakk',
      albumImgPath: 'assets/images/if_you_love_her.jpg',
      audioPath: 'audio/if_You_Love_Her.mp3',
    ),
    SongModel(
      songName: 'Everything Works Out in the End',
      artistName: 'Kodaline',
      albumImgPath: 'assets/images/every_thing_workout.jpg',
      audioPath: 'audio/Kodaline_Everything_Works_Out_in_the_End.mp3',
    ),
    SongModel(
      songName: 'Me and the Devil',
      artistName: 'Soap Skin',
      albumImgPath: 'assets/images/me_and_the_devil.jpg',
      audioPath: 'audio/Soap_Skin_Me_and_the_Devil.mp3',
    ),
    SongModel(
      songName: 'The Night We Met',
      artistName: 'Lord Huron',
      albumImgPath: 'assets/images/the_night_we_met.jpg',
      audioPath: 'audio/The_Night_We_Met.mp3',
    ),
  ];

  int _currentSongIndex = 0;
  List<SongModel> get playList => _playList;
  int get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlayeing;
  Duration get currDuration => _currDuration;
  Duration get totalDuration => _totalDuration;

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  //Duratuon of the song
  Duration _currDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //Constructor
  PlayListProvider() {
    listenToDuration();
  }

  bool _isPlayeing = false;
  bool _isRepeating = false; // <-- Add this line

  bool get isRepeating => _isRepeating; // <-- Add this getter

  void toggleRepeat() {
    _isRepeating = !_isRepeating;
    notifyListeners();
  }
  //play the song
  void playSong() async {
    final String songPath = _playList[_currentSongIndex].audioPath;
    _audioPlayer.stop();
    if (songPath.startsWith('/')) {
      // Play from file
      await _audioPlayer.play(DeviceFileSource(songPath));
    } else {
      // Play from asset
      await _audioPlayer.play(AssetSource(songPath));
    }
    _isPlayeing = true;
    notifyListeners();
  }

  //pause the song
  void pauseSong() async {
    _audioPlayer.pause();
    _isPlayeing = false;
    notifyListeners();
  }

  //resume the song
  void resumeSong() async {
    _audioPlayer.resume();
    _isPlayeing = true;
    notifyListeners();
  }

  //pause Or resume the song
  void pauseOrResumeSong() async {
    if (_isPlayeing) {
      pauseSong();
    } else {
      resumeSong();
    }
    notifyListeners();
  }

  //seek the song
  void seekSong(Duration position) async {
    _audioPlayer.seek(position);
    notifyListeners();
  }

  //play next song
  void playNextSong() async {
    if (_currentSongIndex < _playList.length - 1) {
      _currentSongIndex++;
    } else {
      _currentSongIndex = 0;
    }
    playSong(); // <-- Add this line to start the next song
    notifyListeners();
  }

  //play previous song
  void playPreviousSong() async {
    if (_currDuration.inSeconds > 2) {
      seekSong(Duration.zero);
    } else {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex = _playList.length - 1;
      }
      playSong(); // <-- Add this line to start the previous song
    }
    notifyListeners();
  }

  //listen to the duration of the song
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((neuDuration) {
      _totalDuration = neuDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currDuration = newPosition;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isRepeating) {
        playSong(); // Restart the current song cleanly
      } else {
        playNextSong();
      }
    });
  }

  set currentSongIndex(int index) {
    _currentSongIndex = index;
    playSong();
    notifyListeners();
  }
}
