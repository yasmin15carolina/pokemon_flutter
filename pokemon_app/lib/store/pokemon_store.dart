import 'package:mobx/mobx.dart';
import 'package:pokemon_app/hive/pokemon_hive.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/services/pokemon.service.dart';

import '../models/pokemon_details.dart';
part 'pokemon_store.g.dart';

class PokemonStore = _PokemonStoreBase with _$PokemonStore;

abstract class _PokemonStoreBase with Store {
  @observable
  ObservableList<PokemonModel>? pokemons;

  @observable
  PokemonDetailsModel? pokemonSelected;

  @action
  getAllPokemon() async {
    pokemons = null;
    final res = await PokemonService.getAll();
    if (res.statusCode == 200) {
      List<PokemonModel> list = [];
      for (var pokemon in res.data['results']) {
        list.add(PokemonModel.fromJson(pokemon));
        list.last.favorite = box.get(list.last.name) != null;
        // box.put(
        //   list.last.name!,
        //   PokemonHive(
        //     name: list.last.name!,
        //     url: list.last.url!,
        //     img: list.last.img!,
        //   ),
        // );
        // final img = await PokemonService.getPokemonDetails(list.last.url!);
        // list.last.img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png";
      }
      pokemons = list.asObservable();
    }
  }

  @action
  getPokemonDetails(PokemonModel pokemon) async {
    pokemons = null;
    final res = await PokemonService.getPokemonDetails(pokemon.url!);
    if (res.statusCode == 200) {
      pokemonSelected = PokemonDetailsModel.fromJson(res.data);
      // box.put(
      //     list.last.name!,
      //     PokemonHive(
      //         name: list.last.name!,
      //         url: list.last.url!,
      //         img: list.last.img!));
    }
  }
}
