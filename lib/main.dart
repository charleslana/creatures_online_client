import 'dart:io';

import 'package:creatures_online_client/data/audio_data.dart';
import 'package:creatures_online_client/routes/app_route_generator.dart';
import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    // setWindowMinSize(const Size(400, 400));
    setWindowMaxSize(const Size(320, 600));
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlameAudio.audioCache.loadAll([
    bgMapAudio,
  ]);
  FlameAudio.bgm.initialize();
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creatures Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Exo2Bold',
      ),
      initialRoute: landingRoute,
      onGenerateRoute: AppRouteGenerator.generateRoute,
    );
  }
}
