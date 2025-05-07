import 'package:flutter/material.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:hear_music/core/widgets/home/custom_drawer.dart';
import 'package:hear_music/core/widgets/home/music_List_body.dart';
import 'package:provider/provider.dart';

class MusicsListScreen extends StatelessWidget {
  const MusicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'M U S I C S L I S T',
          style: h5Bold.copyWith(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                    ? AppColors.white
                    : AppColors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: MusicListBody(),
    );
  }
}
