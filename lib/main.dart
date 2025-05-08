import 'package:flutter/material.dart';
import 'package:hear_music/core/models/play_list_provider.dart';
import 'package:hear_music/core/screens/home/musics_list_screen.dart';
import 'package:hear_music/core/services/local_notifications_service.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationsService.init();
  LocalNotificationsService.showRepeatNotification(
    id: 1,
    title: 'Repeat',
    body: 'Repeat music',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<PlayListProvider>(
          create: (_) => PlayListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Wait for theme to load before building the app
    if (themeProvider.prefsServiceLoading == true) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      title: 'My music app',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: const MusicsListScreen(),
    );
  }
}
