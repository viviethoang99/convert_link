part of '../convert_link_screen.dart';

class ListConverUrlWidget extends StatelessWidget {
  const ListConverUrlWidget({
    Key? key,
    required this.listUrl,
  }) : super(key: key);

  final List<String> listUrl;

  @override
  Widget build(BuildContext context) {
    if (listUrl.isUrlsNhentai) {
      return const _ListUrlWidget(
        type: ConvertType.nhentai,
      );
    }
    return Column(
      children: const [
        _ListUrlWidget(
          type: ConvertType.hex,
        ),
        SizedBox(height: 10),
        _ListUrlWidget(
          type: ConvertType.addSpace,
        ),
        SizedBox(height: 10),
        _ListUrlWidget(
          type: ConvertType.addCharacter,
        ),
      ],
    );
  }
}
