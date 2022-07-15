import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../note.dart';

class SpeedDialWidget extends StatelessWidget {
  const SpeedDialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    return BlocBuilder<IncognitoModeCubit, IncognitoModeState>(
      builder: (context, state) {
        final isIncognitoMode = state == IncognitoModeState.on;
        return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22.0),
          activeChild: const Text('close'),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: ValueNotifier<bool>(false),
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          buttonSize: const Size(56.0, 56.0),
          childrenButtonSize: const Size(56.0, 56.0),
          visible: true,
          direction: SpeedDialDirection.up,
          switchLabelPosition: false,
          closeManually: true,
          renderOverlay: false,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          useRotationAnimation: true,
          heroTag: 'speed-dial-hero-tag',
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 600),
          shape: const StadiumBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.history),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              label: 'Lịch sử',
              visible: location != AppPage.listNotes.path,
              onTap: () => context.go(AppPage.listNotes.path),
            ),
            SpeedDialChild(
              child: const Icon(Icons.edit),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              label: 'Chuyển đổi',
              visible: location != AppPage.convert.path,
              onTap: () => context.go(AppPage.convert.path),
            ),
            SpeedDialChild(
              child: isIncognitoMode
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              backgroundColor: isIncognitoMode ? Colors.black : Colors.white,
              foregroundColor: isIncognitoMode ? Colors.white : Colors.black,
              label:
                  isIncognitoMode ? 'Tắt chế độ ẩn danh' : 'Bật chế độ ẩn danh',
              onTap: () => context.read<IncognitoModeCubit>().onTap(),
            ),
          ],
          child: const Text('open'),
        );
      },
    );
  }
}
