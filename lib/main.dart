import 'package:creatures_online_client/routes/app_route_generator.dart';
import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:creatures_online_client/utils/data_audio.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlameAudio.audioCache.loadAll([
    bgMapAudio,
  ]);
  FlameAudio.bgm.initialize();
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
