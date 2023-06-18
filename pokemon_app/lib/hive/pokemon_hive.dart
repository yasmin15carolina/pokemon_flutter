import 'package:hive/hive.dart';

part 'pokemon_hive.g.dart';

@HiveType(typeId: 1)
class PokemonHive {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String url;

  @HiveField(2)
  late String img;

  PokemonHive({
    required this.name,
    required this.url,
    required this.img,
  });
}
