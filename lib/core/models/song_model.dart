import 'dart:convert';

class SongModel {
  final String songName;
  final String artistName;
  final String albumImgPath;
  final String audioPath;

  SongModel({
    required this.songName,
    required this.artistName,
    required this.albumImgPath,
    required this.audioPath,
  });

  // Convert SongModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'songName': songName,
      'artistName': artistName,
      'albumImgPath': albumImgPath,
      'audioPath': audioPath,
    };
  }
  // Convert JSON to SongModel
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      songName: json['songName'],
      artistName: json['artistName'],
      albumImgPath: json['albumImgPath'],
      audioPath: json['audioPath'],
    );
  }
  
  // Add these static helper methods:
  static List<SongModel> listFromJson(String jsonString) {
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => SongModel.fromJson(e)).toList();
  }

  static String listToJson(List<SongModel> songs) {
    final List<Map<String, dynamic>> jsonList = songs.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
