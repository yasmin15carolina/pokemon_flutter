import 'package:dio/dio.dart';
import 'package:pokemon_app/helpers/constants.dart';

class PokemonService {
  static Future<Response> getAll() async {
    return await Dio().get(PokemonAPI.getPokemons);
  }

  static Future<Response> getPokemonDetails(String url) async {
    return await Dio().get(url);
    // return await Dio().get("${PokemonAPI.getPokemonDetails}/$id");
  }
}
