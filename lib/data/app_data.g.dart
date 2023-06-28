// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HighScoreDataAdapter extends TypeAdapter<HighScoreData> {
  @override
  final int typeId = 0;

  @override
  HighScoreData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HighScoreData(
      addHighScore: fields[0] as int,
      subHighScore: fields[1] as int,
      mulHighScore: fields[2] as int,
      divHighScore: fields[3] as int,
      mixHighScore: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HighScoreData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.addHighScore)
      ..writeByte(1)
      ..write(obj.subHighScore)
      ..writeByte(2)
      ..write(obj.mixHighScore)
      ..writeByte(3)
      ..write(obj.divHighScore)
      ..writeByte(4)
      ..write(obj.mixHighScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighScoreDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
