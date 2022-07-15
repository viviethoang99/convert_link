// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_detail_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteDetailDtoAdapter extends TypeAdapter<NoteDetailDto> {
  @override
  final int typeId = 0;

  @override
  NoteDetailDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDetailDto(
      id: fields[0] as String,
      content: fields[1] as String,
      createAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteDetailDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDetailDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
