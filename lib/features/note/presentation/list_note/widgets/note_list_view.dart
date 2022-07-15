import 'package:flutter/material.dart';

import '../../../note.dart';
import 'note_item.dart';
import 'note_list_empty.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({
    Key? key,
    this.noteDetails = const [],
  }) : super(key: key);

  final ListNoteDetails noteDetails;

  @override
  Widget build(BuildContext context) {
    if (noteDetails.isEmpty) {
      return const ListNoteEmpty();
    }
    return ListView.builder(
      itemCount: noteDetails.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (_, index) => NoteItem(item: noteDetails[index]),
    );
  }
}
