import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_app/hive/pokemon_hive.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/views/home.view.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonHiveAdapter());
  box = await Hive.openBox<PokemonHive>('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          appBarTheme: AppBarTheme(color: Colors.green[100])),
      home: const HomeView(),
    );
  }
}
