part of '../convert_link_screen.dart';

class _ListUrlWidget extends StatelessWidget {
  const _ListUrlWidget({required this.type});

  final ConvertType type;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ConvertLinkCubit, ConvertLinkState, List<String>>(
      selector: (state) => state.originalUrl,
      builder: (context, listData) {
        if (listData.isEmpty) {
          return const SizedBox.shrink();
        }
        if (listData.length == 1) {
          return _ItemConvert(
            index: -1,
            text: listData.first.encode(type),
          );
        }
        return Column(
          children: List.generate(
            listData.length,
            (index) => _ItemConvert(
              key: ValueKey('${type.name}_${listData[index]}'),
              index: index,
              text: listData[index].encode(type),
            ),
          ),
        );
      },
    );
  }
}
