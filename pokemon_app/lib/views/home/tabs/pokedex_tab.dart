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

class PokedexTab extends StatefulWidget {
  final List<PokemonModel> pokemons;
  const PokedexTab({super.key, required this.pokemons});

  @override
  State<PokedexTab> createState() => _PokedexTabState();
}

class _PokedexTabState extends State<PokedexTab> {
  PokemonStore pokemonStore = PokemonStore();
  @override
  void initState() {
    pokemonStore.getAllPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if (constraints.maxWidth > 600) {
        //   return _buildWideContainers();
        // } else {
        //   return _buildNormalContainer();
        // }
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: [
              SizedBox(
                  height: constraints.maxHeight * 0.9,
                  child: pokemonList(constraints.maxHeight * 0.9)),
              SizedBox(
                  height: constraints.maxHeight * 0.1, child: paginationBtn()),
            ],
          ),
        );
      },
    );
  }

  Widget pokemonList(double maxHeight) {
    List<Widget> listview = [];
    return Observer(builder: (_) {
      if (pokemonStore.pokemons == null) {
        return const SpinKitThreeBounce(
          color: Colors.green,
          size: 20,
        );
      }
      listview = pokemonStore.pokemons!
          .map(
            (poke) => Observer(builder: (context) {
              return PokemonCard(
                  poke: poke,
                  maxHeight: maxHeight,
                  onTap: (newcontext) async {},
                  toggleFavorite: () => pokemonStore.toggleFavorite(poke)
                  // () {
                  //   setState(() {});
                  // },
                  );
            }),
          )
          .toList();
      //listview.add(paginationBtn());
      return ListView(
        children: listview,
      );
    });
  }

  Widget buildPokemonCard(PokemonModel poke, double maxHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: maxHeight * 0.015),
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
                placeholder: (context, url) => SpinKitThreeBounce(
                  color: Colors.green,
                  size: 20,
                ), // Indicador de carregamento
                imageUrl: poke.img!,
                fit: BoxFit.contain,
                height: maxHeight / 5.8,
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
                  padding: EdgeInsets.all(maxHeight / 25),
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

  Widget paginationBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return ElevatedButton(
              onPressed: pokemonStore.offset == 0
                  ? null
                  : () {
                      pokemonStore.previousPage();
                    },
              child: Icon(Icons.arrow_back),
            );
          }),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              pokemonStore.nextPage();
            },
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
