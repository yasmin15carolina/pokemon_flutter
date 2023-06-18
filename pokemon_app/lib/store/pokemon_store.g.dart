// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStoreBase, Store {
  late final _$pokemonsAtom =
      Atom(name: '_PokemonStoreBase.pokemons', context: context);

  @override
  ObservableList<PokemonModel>? get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<PokemonModel>? value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$pokemonSelectedAtom =
      Atom(name: '_PokemonStoreBase.pokemonSelected', context: context);

  @override
  PokemonDetailsModel? get pokemonSelected {
    _$pokemonSelectedAtom.reportRead();
    return super.pokemonSelected;
  }

  @override
  set pokemonSelected(PokemonDetailsModel? value) {
    _$pokemonSelectedAtom.reportWrite(value, super.pokemonSelected, () {
      super.pokemonSelected = value;
    });
  }

  late final _$getAllPokemonAsyncAction =
      AsyncAction('_PokemonStoreBase.getAllPokemon', context: context);

  @override
  Future getAllPokemon() {
    return _$getAllPokemonAsyncAction.run(() => super.getAllPokemon());
  }

  late final _$getPokemonDetailsAsyncAction =
      AsyncAction('_PokemonStoreBase.getPokemonDetails', context: context);

  @override
  Future getPokemonDetails(PokemonModel pokemon) {
    return _$getPokemonDetailsAsyncAction
        .run(() => super.getPokemonDetails(pokemon));
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
pokemonSelected: ${pokemonSelected}
    ''';
  }
}
