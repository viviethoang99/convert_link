import 'package:equatable/equatable.dart';

class NoteDetailQuery extends Equatable {
  const NoteDetailQuery({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
