import 'package:pokemon_app/helpers/constants.dart';

class PokemonModel {
  String? name;
  String? url;
  String? img;
  bool? favorite;
  PokemonModel({
    this.name,
    this.url,
    this.img,
    this.favorite,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    List urlList = json['url'].split('/');
    img = "${PokemonAPI.getOfficialArtwork}/${urlList[urlList.length - 2]}.png";
  }
}
