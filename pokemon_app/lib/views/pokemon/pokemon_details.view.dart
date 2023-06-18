import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokemon_app/models/pokemon_details.dart';
import 'package:pokemon_app/store/pokemon_store.dart';

import '../../helpers/constants.dart';

class PokemonDetailsView extends StatefulWidget {
  final PokemonDetailsModel? pokemon;
  const PokemonDetailsView({super.key, required this.pokemon});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView>
    with TickerProviderStateMixin {
  PokemonStore pokemonStore = PokemonStore();
  List<String> tabs = ['About', 'Stats', 'Moves'];
  TabController? _tabController;

  @override
  void initState() {
    pokemonStore.pokemonSelected = widget.pokemon;
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text("${pokemonStore.pokemonSelected!.name}"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/pokemon.png',
              scale: 20,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: body(constraints.maxHeight),
          );
        },
      ),
    );
  }

  body(double maxHeight) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.only(
                top: maxHeight * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.2,
                        child: TabBar(
                          controller: _tabController,
                          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ListView(children: [
                                buildTypes(),
                                buildAbilities(),
                                buildHeight(),
                                buildWeight(),
                              ]),
                              ListView(children: [
                                builStats(),
                              ]),
                              ListView(children: [
                                buildMoves(),
                                // movesW()
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
        Align(
            alignment: Alignment(0, -0.7),
            child: CachedNetworkImage(
              placeholder: (context, url) => const SpinKitThreeBounce(
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
                .map((type) => buildChip(type.type!.name!, Colors.purple[400]))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildAbilities() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Abilities",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            children: pokemonStore.pokemonSelected!.abilities!
                .map((ability) =>
                    buildChip(ability.ability!.name!, Colors.blue[300]))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildChip(String label, Color? color) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Text(label, style: TextStyle(color: Colors.white)),
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
        pokemonStore.pokemonSelected!.stats!.map((e) => stat(e)).toList());
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(pokemonStat.baseStat!.toString()),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Container(
                    height: 20,
                    width: pokemonStat.baseStat!.toDouble() *
                        ((MediaQuery.of(context).size.width / 1.5) / 255),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoves() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: pokemonStore.pokemonSelected!.moves!
              .map(
                (m) => Observer(builder: (context) {
                  return Column(
                    children: [
                      Observer(builder: (_) {
                        return InkWell(
                          onTap: () => pokemonStore.showMoveDetails(m),
                          child: buildChip(
                            m.move!.name!,
                            Colors.purple[300],
                          ),
                        );
                      }),
                      Observer(builder: (_) {
                        return Visibility(
                          visible: pokemonStore.moves != null &&
                              pokemonStore.moves == m,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text("level")),
                              DataColumn(label: Text("method")),
                              DataColumn(label: Text("version")),
                            ],
                            rows: m.versionGroupDetails!
                                .map((v) => DataRow(cells: [
                                      DataCell(
                                          Text(v.levelLearnedAt!.toString())),
                                      DataCell(Text(
                                          v.moveLearnMethod!.name.toString())),
                                      DataCell(Text(
                                          v.versionGroup!.name.toString())),
                                    ]))
                                .toList(),
                          ),
                        );
                      }),
                    ],
                  );
                }),
              )
              .toList(),
        )

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       "Abilities",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     Wrap(
        //       children: pokemonStore.pokemonSelected!.moves!
        //           .map((move) => buildType(move.move!.name!))
        //           .toList(),
        //     ),
        //   ],
        // ),
        );
  }

  movesW() {
    return Wrap(
      children: pokemonStore.pokemonSelected!.moves!
          .map(
            (m) => InkWell(
              onTap: () {},
              child: buildChip(m.move!.name!, Colors.purple[300]),
            ),
          )
          .toList(),
    );
  }
}
