import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/store/pokemon_store.dart';
import 'package:pokemon_app/views/pokemon/pokemon_details.view.dart';
import 'package:pokemon_app/widgets/pokemon_card.dart';

import '../../../hive/pokemon_hive.dart';

class FavoritesTab extends StatefulWidget {
  final List<PokemonModel> favorites;
  const FavoritesTab({
    Key? key,
    required this.favorites,
  }) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  PokemonStore pokemonStore = PokemonStore();
  @override
  void initState() {
    pokemonStore.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      body: listFavorites(MediaQuery.of(context).size.height * 0.8),
    );
  }

  Widget buildPokemonCard(PokemonModel poke) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () async {
          await pokemonStore.getPokemonDetails(poke);
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) =>
                    PokemonDetailsView(pokemon: pokemonStore.pokemonSelected),
              ))
              .then((value) => pokemonStore.getAllPokemon());
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Text(poke.url!),
              CachedNetworkImage(
                placeholder: (context, url) => const SpinKitThreeBounce(
                  color: Colors.green,
                  size: 20,
                ), // Indicador de carregamento
                imageUrl: poke.img!,
                fit: BoxFit.contain,
                height: 100,
              ),
              Text(poke.name!),
              InkWell(
                onTap: () {
                  setState(() {
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
                    poke.favorite = box.get(poke.name) != null;
                  });
                },
                child: Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.all(30),
                  child: Icon(
                      poke.favorite! ? MdiIcons.heart : MdiIcons.heartOutline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listFavorites(double maxHeight) {
    return Observer(builder: (_) {
      if (pokemonStore.pokemons == null) {
        return const SpinKitThreeBounce(
          color: Colors.green,
          size: 20,
        );
      }
      return ListView(
        children: pokemonStore.pokemons!
            .map((poke) => PokemonCard(
                poke: poke,
                maxHeight: maxHeight,
                onTap: () async {
                  await pokemonStore.getPokemonDetails(poke);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) => PokemonDetailsView(
                            pokemon: pokemonStore.pokemonSelected),
                      ))
                      .then((value) => pokemonStore.getAllPokemon());
                },
                toggleFavorite: () {
                  setState(() {
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
                    poke.favorite = box.get(poke.name) != null;
                  });
                }))
            .toList(),
      );
    });
  }
}
