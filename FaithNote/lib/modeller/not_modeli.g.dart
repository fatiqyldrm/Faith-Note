part of 'not_modeli.dart';

class NotModeliAdapter extends TypeAdapter<NotModeli> {
  @override
  final int typeId = 0;

  @override
  NotModeli read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotModeli(
      baslik: fields[0] as String,
      aciklama: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotModeli obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.baslik)
      ..writeByte(1)
      ..write(obj.aciklama);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotModeliAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
