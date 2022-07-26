import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../note.dart';

part 'widget/link_widget.dart';
part 'widget/list_origina_url_result.dart';
part 'widget/text_field_input.dart';
part 'widget/app_bar.dart';
part 'widget/convert_link.dart';
part 'widget/list_convert_url.dart';

class ConvertLinkScreen extends StatelessWidget {
  const ConvertLinkScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  final String? id;

  bool get isHistory {
    return id?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isHistory
          ? AppBar(
              title: const Text('Lịch sử '),
              centerTitle: true,
            )
          : null,
      floatingActionButton: const SpeedDialWidget(),
      body: BlocProvider(
        create: (_) => getIt<ConvertLinkCubit>()..initLoading(id),
        child: const ConvertLink(),
      ),
    );
  }
}
