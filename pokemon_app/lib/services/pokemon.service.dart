import 'package:dio/dio.dart';
import 'package:pokemon_app/helpers/constants.dart';

class PokemonService {
  static Future<Response> getPokemons(
      {required int offset, required int limit}) async {
    return await Dio()
        .get("${PokemonAPI.getPokemons}?offset=$offset&limit=$limit");
  }

  static Future<Response> getPokemonDetails(String url) async {
    return await Dio().get(url);
    // return await Dio().get("${PokemonAPI.getPokemonDetails}/$id");
  }
}
