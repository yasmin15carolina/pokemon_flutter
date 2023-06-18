import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokemon_app/hive/pokemon_hive.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/models/pokemon_details.dart';
import 'package:pokemon_app/store/pokemon_store.dart';

import '../helpers/constants.dart';

class PokemonDetailsView extends StatefulWidget {
  final PokemonDetailsModel? pokemon;
  const PokemonDetailsView({super.key, required this.pokemon});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  PokemonStore pokemonStore = PokemonStore();
  @override
  void initState() {
    pokemonStore.pokemonSelected = widget.pokemon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text("${pokemonStore.pokemonSelected!.name}"),
        centerTitle: true,
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final PokemonHive obj = box.get(pokemonStore.pokemonSelected!.name);
        final List<PokemonHive> res = box.values as List<PokemonHive>;

        print(obj.name);
      }),
    );
  }

  body() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.only(top: 60, left: 30),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: ListView(
                children: [
                  buildTypes(),
                  buildHeight(),
                  buildWeight(),
                  builStats(),
                ],
              )),
        ),
        Align(
            alignment: Alignment(0, -0.7),
            child: CachedNetworkImage(
              placeholder: (context, url) => SpinKitThreeBounce(
                color: Colors.green,
                size: 20,
              ), // Indicador de carregamento
              imageUrl:
                  "${PokemonAPI.getOfficialArtwork}/${pokemonStore.pokemonSelected!.id!}.png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height / 3.5,
            )),
      ],
    );

    return ListView(
      children: [
        Center(
          child: Image.network(
              pokemonStore.pokemonSelected!.sprites!.frontDefault!,
              scale: 0.5),
        ),
        Text("height: ${pokemonStore.pokemonSelected!.height! / 10} m"),
        Text("weight: ${pokemonStore.pokemonSelected!.weight! / 10} kg"),
        Text("type: ${pokemonStore.pokemonSelected!.types!.first.type!.name}"),
        Text("type: ${pokemonStore.pokemonSelected!.types!.first.type!.name}"),
      ],
    );
  }

  Widget buildTypes() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            children: pokemonStore.pokemonSelected!.types!
                .map((type) => buildType(type.type!.name!))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildType(String type) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.purple[400]),
      child: Text(type, style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildWeight() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "Weight: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(" ${pokemonStore.pokemonSelected!.weight! / 10} kg"),
          ],
        ));
  }

  Widget buildHeight() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "Height: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(" ${pokemonStore.pokemonSelected!.height! / 10} m"),
          ],
        ));
  }

  Widget builStats() {
    List<Widget> stats = [
      Text(
        "Stats",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      )
    ];
    stats.addAll(
        pokemonStore.pokemonSelected!.stats!.map((e) => stat(e!)).toList());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: stats),
    );
  }

  Widget stat(Stats pokemonStat) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Text(
              pokemonStat.stat!.name!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 20,
                width: pokemonStat.baseStat!.toDouble() *
                    (MediaQuery.of(context).size.width / 255),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
