import 'package:hear_music/core/models/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _themeKey = 'theme_key';
  static const String _isFirstTimeKey = 'is_first_time_key';
  static const String _isDarkModeKey = 'is_dark_mode_key';
  //add playlist key
  static const String _playlistKey = 'playlist_key';
  

  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  Future<void> setTheme(String theme) async {
    await _sharedPreferences.setString(_themeKey, theme);
  }

  String getTheme() {
    return _sharedPreferences.getString(_themeKey) ?? 'light';
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    await _sharedPreferences.setBool(_isFirstTimeKey, isFirstTime);
  }

  bool getIsFirstTime() {
    return _sharedPreferences.getBool(_isFirstTimeKey) ?? true;
  }

  Future<void> setIsDarkMode(bool isDarkMode) async {
    await _sharedPreferences.setBool(_isDarkModeKey, isDarkMode);
  }

  bool getIsDarkMode() {
    return _sharedPreferences.getBool(_isDarkModeKey) ?? false;
  }

  //add List<SongModel> playlist to shared preferences
  Future<void> setPlayList(List<SongModel> playList) async {
    final String jsonString = SongModel.listToJson(playList);
    await _sharedPreferences.setString(_playlistKey, jsonString);
  }
  
  //get List<SongModel> playlist from shared preferences
  List<SongModel> getPlayList() {
    final String? jsonString = _sharedPreferences.getString(_playlistKey);
    if (jsonString == null) return [];
    return SongModel.listFromJson(jsonString);
  }
}
