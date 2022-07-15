import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';

class ListNoteEmpty extends StatelessWidget {
  const ListNoteEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Không có bản ghi nào.',
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: () => context.go(AppPage.convert.path),
            child: const Text(
              'Quay lại',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
