import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart';
import '../../note.dart';
import 'widgets/note_list_view.dart';

part 'widgets/notes_widget.dart';
part 'widgets/app_bar.dart';

class ListNoteScreen extends StatelessWidget {
  const ListNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NoteCubit>()..watchAllNotes(),
      child: const Scaffold(
        floatingActionButton: SpeedDialWidget(),
        appBar: AppBarListNote(),
        body: NotesWidget(),
      ),
    );
  }
}
