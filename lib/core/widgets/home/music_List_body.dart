import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hear_music/core/models/play_list_provider.dart';
import 'package:hear_music/core/screens/music/music_details_screen.dart';
import 'package:hear_music/core/widgets/music/nue_box.dart';
import 'package:provider/provider.dart';

class MusicListBody extends StatefulWidget {
  const MusicListBody({super.key});

  @override
  State<MusicListBody> createState() => _MusicListBodyState();
}

class _MusicListBodyState extends State<MusicListBody> {
  late final dynamic playListProvider;

  // This method is called when the widget is first created.
  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  //go to the song
  void goToSong(int index) {
    playListProvider.currentSongIndex = index;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongDetailsScreen()),
    );
    // Add your logic to navigate to the song details screen or play the song
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (BuildContext context, PlayListProvider value, Widget? child) {
        return ListView.builder(
          itemCount: value.playList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: NueBox(
                child: Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: value.playList[index].albumImgPath.startsWith('/')
                              ? Image.file(
                                  File(value.playList[index].albumImgPath),
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  value.playList[index].albumImgPath,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      title: Text(value.playList[index].songName),
                      subtitle: Text(value.playList[index].artistName),
                      onTap: () {
                        goToSong(
                          index,
                        ); // Call the method to navigate to the song
                      },
                      trailing: IconButton(
                        icon: Icon(
                          (value.isPlaying && value.currentSongIndex == index)
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          if (value.isPlaying &&
                              value.currentSongIndex == index) {
                            value.pauseSong();
                          } else {
                            value.currentSongIndex = index;
                          }
                        },
                      ),
                    ),
                    if (value.currentSongIndex == index && value.isPlaying)
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          value:
                              value.currDuration.inSeconds
                                  .clamp(
                                    0,
                                    value.totalDuration.inSeconds > 0
                                        ? value.totalDuration.inSeconds
                                        : 1,
                                  )
                                  .toDouble(),
                          max:
                              value.totalDuration.inSeconds > 0
                                  ? value.totalDuration.inSeconds.toDouble()
                                  : 1.0,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {},
                          onChangeEnd: (double double) {
                            value.seekSong(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
