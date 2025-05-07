import 'package:flutter/material.dart';
import 'package:hear_music/core/func/func.dart';
import 'package:hear_music/core/models/play_list_provider.dart';
import 'package:hear_music/core/models/song_model.dart';
import 'package:hear_music/core/screens/home/musics_list_screen.dart';
import 'package:hear_music/core/services/local_notifications_service.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:hear_music/core/widgets/custom_button.dart';
import 'package:hear_music/core/widgets/cutom_device_button.dart';
import 'package:hear_music/core/widgets/music/custom_input_field.dart';
import 'package:hear_music/core/widgets/music/nue_box.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hear_music/core/services/shared_prefrences.dart';

class AddMusicScreen extends StatefulWidget {
  const AddMusicScreen({super.key});

  @override
  State<AddMusicScreen> createState() => _AddMusicScreenState();
}

class _AddMusicScreenState extends State<AddMusicScreen> {
  final TextEditingController musicNameController = TextEditingController();
  final TextEditingController artistNameController = TextEditingController();
  String? savedImgPath;
  String? savedAudioPath;
  SharedPreferencesService? _prefsService;

  @override
  void dispose() {
    musicNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsService = SharedPreferencesService(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'A D D Y O U R M U S I C',
              style: h5Bold.copyWith(
                color:
                    Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).isDarkMode
                        ? AppColors.white
                        : AppColors.black,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color:
                    Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).isDarkMode
                        ? AppColors.white
                        : AppColors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MusicsListScreen(),
                  ),
                ); // Close the settings screen
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CustomInputField(
                    inputFiledController: musicNameController,
                    hintTxt: 'M U S I C N A M E',
                    labelTxt: 'M U S I C N A M E',
                    validator: (validator) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomInputField(
                    inputFiledController: artistNameController,
                    hintTxt: 'A R T I S T N A M E',
                    labelTxt: 'A R T I S T N A M E',
                    validator: (validator) {
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),
                  //elevated button to add music image using pickImageFromGallery method
                  NueBox(
                    child: CustomDeviceButton(
                      onPressed: () async {
                        final pickedImgPath = await pickImageFromGallery();
                        if (pickedImgPath != null) {
                          final musicName = sanitizeFileName(
                            musicNameController.text.isNotEmpty
                                ? musicNameController.text
                                : DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          );
                          final fileName = '$musicName.jpg';
                          final imgPath = await saveFileToAppDir(
                            pickedImgPath,
                            fileName,
                          );
                          setState(() {
                            savedImgPath = imgPath;
                          });
                          print('Saved image path: $savedImgPath');
                        } else {
                          print('No image selected');
                        }
                      },
                      child:
                      // savedImgPath != null
                      //     ? SizedBox(
                      //       width: 200,
                      //       height: 200,
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(8),
                      //         child:
                      //             savedImgPath != null
                      //                 ? Image.file(
                      //                   File(savedImgPath!),
                      //                   width: 200,
                      //                   height: 200,
                      //                   fit: BoxFit.cover,
                      //                 )
                      //                 : Image.asset(
                      //                   'assets/images/the_night_we_met.jpg',
                      //                   width: double.infinity,
                      //                   height: 300,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //       ),
                      //     )
                      //
                      Text(
                        'Pick Image',
                        style: title2Bold.copyWith(
                          color:
                              Provider.of<ThemeProvider>(
                                    context,
                                    listen: false,
                                  ).isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  NueBox(
                    child: CustomDeviceButton(
                      child: Text(
                        'Pick Audio',
                        style: title2Bold.copyWith(
                          color:
                              Provider.of<ThemeProvider>(
                                    context,
                                    listen: false,
                                  ).isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                        ),
                      ),
                      onPressed: () async {
                        final pickedAudioPath = await pickAudioFromDevice();
                        if (pickedAudioPath != null) {
                          final musicName = sanitizeFileName(
                            musicNameController.text.isNotEmpty
                                ? musicNameController.text
                                : DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          );
                          final fileName = '$musicName.mp3';
                          final audioPath = await saveFileToAppDir(
                            pickedAudioPath,
                            fileName,
                          );
                          setState(() {
                            savedAudioPath = audioPath;
                          });
                          print('Saved audio path: $savedAudioPath');
                        } else {
                          print('No audio selected');
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: ActionBtn(
                      btnText: 'A D D M U S I C',
                      width: double.infinity,
                      onPressed: () async {
                        String musicName = musicNameController.text;
                        String artistName = artistNameController.text;
                        if (musicName.isNotEmpty && artistName.isNotEmpty) {
                          value.playList.add(
                            SongModel(
                              songName: musicName,
                              artistName: artistName,
                              albumImgPath:
                                  savedImgPath ??
                                  'assets/images/the_night_we_met.jpg',
                              audioPath:
                                  savedAudioPath ??
                                  'audio/The_Night_We_Met.mp3',
                            ),
                          );

                          // Save updated playlist to SharedPreferences
                          if (_prefsService != null) {
                            await _prefsService!.setPlayList(value.playList);
                          }

                          LocalNotificationsService.showNotification(
                            id: 0,
                            title: 'New Music Added',
                            body: 'You have added a new music: $musicName',
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MusicsListScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<String> saveFileToAppDir(String originalPath, String newFileName) async {
  final appDir = await getApplicationDocumentsDirectory();
  final newPath = p.join(appDir.path, newFileName);
  final file = File(originalPath);
  final newFile = await file.copy(newPath);
  return newFile.path;
}
