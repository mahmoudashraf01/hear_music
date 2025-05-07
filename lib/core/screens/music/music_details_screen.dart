import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hear_music/core/models/play_list_provider.dart';
import 'package:hear_music/core/screens/home/musics_list_screen.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:hear_music/core/widgets/music/nue_box.dart';
import 'package:provider/provider.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        final playList = value.playList;
        final currentSongIndex = playList[value.currentSongIndex];
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'P L A Y L I S T',
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  size: 27,
                  color:
                      Provider.of<ThemeProvider>(
                            context,
                            listen: false,
                          ).isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: Column(
                children: [
                  NueBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
            
                          child:
                              currentSongIndex.albumImgPath.startsWith('/')
                                  ? Image.file(
                                    File(currentSongIndex.albumImgPath),
                                    width: double.infinity,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    currentSongIndex.albumImgPath,
                                    width: double.infinity,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // <-- Add this
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSongIndex.songName,
                                      overflow: TextOverflow.ellipsis,
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
                                    Text(
                                      currentSongIndex.artistName,
                                      style: title2Bold.copyWith(
                                        color:
                                            Provider.of<ThemeProvider>(
                                                  context,
                                                  listen: false,
                                                ).isDarkMode
                                                ? AppColors.white
                                                : AppColors.greydarker800,
                                      ),
                                    ),
                                  ],
                                ),
                              ), // <-- End Expanded
                              Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${value.currDuration.inMinutes}:${(value.currDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: title2Bold.copyWith(
                                color:
                                    Provider.of<ThemeProvider>(
                                          context,
                                          listen: false,
                                        ).isDarkMode
                                        ? AppColors.white
                                        : AppColors.greydarker800,
                              ),
                            ),
                            Icon(Icons.shuffle),
                            IconButton(
                              onPressed: value.toggleRepeat,
                              icon: Icon(
                                Icons.repeat,
                                color:
                                    value.isRepeating
                                        ? Colors.green
                                        : (Provider.of<ThemeProvider>(
                                              context,
                                              listen: false,
                                            ).isDarkMode
                                            ? AppColors.white
                                            : AppColors.greydarker800),
                              ),
                            ),
                            Text(
                              '${value.totalDuration.inMinutes}:${(value.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: title2Bold.copyWith(
                                color:
                                    Provider.of<ThemeProvider>(
                                          context,
                                          listen: false,
                                        ).isDarkMode
                                        ? AppColors.white
                                        : AppColors.greydarker800,
                              ),
                            ),
                          ],
                        ),
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
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NueBox(child: Icon(Icons.skip_previous)),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResumeSong,
                          child: NueBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
            
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NueBox(child: Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
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
