import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/store/pokemon_store.dart';

import '../views/pokemon/pokemon_details.view.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel poke;
  final double maxHeight;
  final Function onTap;
  final Function toggleFavorite;

  final PokemonStore pokemonStore = PokemonStore();
  PokemonCard({
    super.key,
    required this.poke,
    required this.maxHeight,
    required this.onTap,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: maxHeight * 0.015),
      child: InkWell(
        onTap: // () => onTap(context),
            () async {
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
                onTap: () => toggleFavorite(),
                // () {
                //   setState(() {
                //     if (poke.favorite!) {
                //       box.delete(poke.name!);
                //     } else {
                //       box.put(
                //         poke.name!,
                //         PokemonHive(
                //           name: poke.name!,
                //           url: poke.url!,
                //           img: poke.img!,
                //         ),
                //       );
                //     }
                //     poke.favorite = box.get(poke.name) != null;
                //   });
                // },
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
}
