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
  Exception? error;

  @observable
  ObservableList<PokemonModel>? pokemons;

  @observable
  PokemonDetailsModel? pokemonSelected;

  @observable
  int offset = 0;

  int limit = 5;

  @observable
  Moves? moves;

  @action
  getAllPokemon() async {
    pokemons = null;
    try {
      final res =
          await PokemonService.getPokemons(limit: limit, offset: offset);
      if (res.statusCode == 200) {
        List<PokemonModel> list = [];
        for (var pokemon in res.data['results']) {
          list.add(PokemonModel.fromJson(pokemon));
          list.last.favorite = box.get(list.last.name) != null;
        }
        pokemons = list.asObservable();
      }
    } catch (e) {
      error = e as Exception;
    }
  }

  @action
  getPokemonDetails(PokemonModel pokemon) async {
    pokemons = null;
    try {
      final res = await PokemonService.getPokemonDetails(pokemon.url!);
      if (res.statusCode == 200) {
        pokemonSelected = PokemonDetailsModel.fromJson(res.data);
      }
    } catch (e) {
      error = e as Exception;
    }
  }

  @action
  getFavorites() async {
    final List list = box.values.toList();
    List<PokemonModel> favorites = [];
    for (int i = 0; i < list.length; i++) {
      favorites.add(PokemonModel(
        name: list[i].name,
        url: list[i].url,
        img: list[i].img,
        favorite: true,
      ));
    }
    pokemons = favorites.asObservable();
  }

  @action
  toggleFavorite(PokemonModel poke) async {
    if (poke.favorite!) {
      box.delete(poke.name!);
    } else {
      box.put(
        poke.name!,
        PokemonHive(
          name: poke.name!,
          url: poke.url!,
          img: poke.img!,
        ),
      );
    }
    pokemons![pokemons!.indexOf(poke)].favorite = box.get(poke.name) != null;
    pokemons = pokemons!.asObservable();
  }

  nextPage() {
    offset = offset + limit;
    getAllPokemon();
  }

  previousPage() {
    if (offset > 0) {
      offset = offset - limit;
      getAllPokemon();
    }
  }

  @action
  showMoveDetails(Moves m) {
    if (moves != m) {
      moves = m;
    } else {
      moves = null;
    }
  }
}
