part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteSuccess extends NoteState {
  const NoteSuccess(this.listNote);

  final List<NoteDetail> listNote;

  @override
  List<Object> get props => [listNote];
}

class NoteFailed extends NoteState {}
