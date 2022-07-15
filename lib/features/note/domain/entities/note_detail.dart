import 'package:equatable/equatable.dart';

typedef NoteDetails = List<NoteDetail>;

class NoteDetail extends Equatable {
  const NoteDetail({
    required this.id,
    required this.content,
    required this.createAt,
  });

  final String id;
  final String content;
  final DateTime createAt;

  @override
  List<Object?> get props => [id, content, createAt];
}
