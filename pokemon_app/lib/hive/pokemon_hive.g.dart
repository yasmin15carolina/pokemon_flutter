// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonHiveAdapter extends TypeAdapter<PokemonHive> {
  @override
  final int typeId = 1;

  @override
  PokemonHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonHive(
      name: fields[0] as String,
      url: fields[1] as String,
      img: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
