import 'package:hive/hive.dart';

import '../../../domain/entities/note_detail.dart';

part 'note_detail_dto.g.dart';

typedef ListNoteDetails = List<NoteDetail>;

@HiveType(typeId: 0)
class NoteDetailDto {
  const NoteDetailDto({
    required this.id,
    required this.content,
    required this.createAt,
  });

  factory NoteDetailDto.toNote(NoteDetail note) {
    return NoteDetailDto(
      id: note.id,
      content: note.content,
      createAt: note.createAt,
    );
  }

  NoteDetail toEntity() {
    return NoteDetail(
      id: id,
      content: content,
      createAt: createAt,
    );
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final DateTime createAt;
}

extension NoteDetailDtoX on List<NoteDetailDto> {
  List<NoteDetail> toEntities() => map((dto) => dto.toEntity()).toList();
}
