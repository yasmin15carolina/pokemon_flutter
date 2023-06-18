// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStoreBase, Store {
  late final _$errorAtom =
      Atom(name: '_PokemonStoreBase.error', context: context);

  @override
  Exception? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

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

  late final _$offsetAtom =
      Atom(name: '_PokemonStoreBase.offset', context: context);

  @override
  int get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(int value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  late final _$movesAtom =
      Atom(name: '_PokemonStoreBase.moves', context: context);

  @override
  Moves? get moves {
    _$movesAtom.reportRead();
    return super.moves;
  }

  @override
  set moves(Moves? value) {
    _$movesAtom.reportWrite(value, super.moves, () {
      super.moves = value;
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

  late final _$getFavoritesAsyncAction =
      AsyncAction('_PokemonStoreBase.getFavorites', context: context);

  @override
  Future getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('_PokemonStoreBase.toggleFavorite', context: context);

  @override
  Future toggleFavorite(PokemonModel poke) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(poke));
  }

  late final _$_PokemonStoreBaseActionController =
      ActionController(name: '_PokemonStoreBase', context: context);

  @override
  dynamic showMoveDetails(Moves m) {
    final _$actionInfo = _$_PokemonStoreBaseActionController.startAction(
        name: '_PokemonStoreBase.showMoveDetails');
    try {
      return super.showMoveDetails(m);
    } finally {
      _$_PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
pokemons: ${pokemons},
pokemonSelected: ${pokemonSelected},
offset: ${offset},
moves: ${moves}
    ''';
  }
}
