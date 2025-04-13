// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Azkar_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZekrAdapter extends TypeAdapter<Zekr> {
  @override
  final int typeId = 0;

  @override
  Zekr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Zekr(
      text: fields[0] as String,
      count: fields[1] as int,
      type: fields[2] as AzkarType,
      added: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Zekr obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.added);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZekrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AzkarTypeAdapter extends TypeAdapter<AzkarType> {
  @override
  final int typeId = 1;

  @override
  AzkarType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AzkarType.morning;
      case 1:
        return AzkarType.night;
      case 2:
        return AzkarType.praying;
      case 3:
        return AzkarType.saving;
      case 4:
        return AzkarType.sleep;
      case 5:
        return AzkarType.wakeUp;
      case 6:
        return AzkarType.mosque;
      case 7:
        return AzkarType.mostazed;
      case 8:
        return AzkarType.ahadeth;
      default:
        return AzkarType.morning;
    }
  }

  @override
  void write(BinaryWriter writer, AzkarType obj) {
    switch (obj) {
      case AzkarType.morning:
        writer.writeByte(0);
        break;
      case AzkarType.night:
        writer.writeByte(1);
        break;
      case AzkarType.praying:
        writer.writeByte(2);
        break;
      case AzkarType.saving:
        writer.writeByte(3);
        break;
      case AzkarType.sleep:
        writer.writeByte(4);
        break;
      case AzkarType.wakeUp:
        writer.writeByte(5);
        break;
      case AzkarType.mosque:
        writer.writeByte(6);
        break;
      case AzkarType.mostazed:
        writer.writeByte(7);
        break;
      case AzkarType.ahadeth:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AzkarTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
