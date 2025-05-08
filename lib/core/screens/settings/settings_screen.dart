import 'package:flutter/material.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'S E T T I N G S',
          style: h5Bold.copyWith(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
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
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                    ? AppColors.white
                    : AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Close the settings screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                      ? [
                        AppColors.greydarker600,
                        AppColors.greydarker300,
                        
                      ]
                      : [
                        AppColors.greydarker500,
                        AppColors.greydarker300,
                      ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Mode', style: title1Bold),
              Switch(
                activeColor: Theme.of(context).colorScheme.inversePrimary,
                inactiveThumbColor:
                    Theme.of(context).colorScheme.inversePrimary,
                inactiveTrackColor: Theme.of(context).colorScheme.secondary,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                value:
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).isDarkMode, // Replace with your dark mode state
                onChanged: (value) {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme(); // Call the toggle function
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
