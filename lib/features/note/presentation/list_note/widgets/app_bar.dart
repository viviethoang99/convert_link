part of '../list_note_screen.dart';

class AppBarListNote extends StatelessWidget implements PreferredSizeWidget {
  const AppBarListNote({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteSuccess && state.listNote.isNotEmpty) {
              return TextButton(
                onPressed: () async {
                  await _showDialogDeleteAll(context).then(
                    (value) => context.read<NoteCubit>().deleteAllNote(value),
                  );
                },
                child: const Text(
                  'Xoá toàn bộ ghi chú',
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Future<bool?> _showDialogDeleteAll(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xoá toàn bộ ghi chú'),
        content: const Text(
          'Bạn chắc muốn xoá toàn bộ ghi chú trong ứng dụng của mình chứ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Không xoá nữa'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Xoá chứ',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
