import 'package:flutter/material.dart';
import 'package:hear_music/core/screens/music/add_music_screen.dart';
import 'package:hear_music/core/screens/settings/settings_screen.dart';
import 'package:hear_music/core/styles/color.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              // Remove any border or background to eliminate the line
              color: Colors.transparent,
              border: Border(bottom: BorderSide.none),
            ),
            child: Center(
              child: Icon(
                Icons.music_note,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              leading: Icon(Icons.home, color: AppColors.greydarker600),
              title: const Text('H O M E'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              leading: Icon(Icons.settings, color: AppColors.greydarker600),
              title: const Text('S E T T I N G S'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              leading: Icon(Icons.music_note, color: AppColors.greydarker600),
              title: const Text('A D D M US I C S'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMusicScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
