part of '../convert_link_screen.dart';

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    return location == AppPage.convert.path
        ? SizedBox(
            height: 80,
            width: double.infinity,
            child: BlocSelector<ConvertLinkCubit, ConvertLinkState, bool>(
              selector: (state) => state.userInput.isNotEmpty,
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: state
                      ? CloseButton(
                          onPressed: context.read<ConvertLinkCubit>().clearData,
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
