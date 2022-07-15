part of '../convert_link_screen.dart';

class _ItemConvert extends StatelessWidget {
  const _ItemConvert({
    super.key,
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          if (index != -1)
            Container(
              padding: const EdgeInsets.only(right: 10),
              margin: const EdgeInsets.only(right: 7),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 7),
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(1000),
              ),
              height: 40,
              width: 40,
              child: InkWell(
                onTap: () =>
                    context.read<ConvertLinkCubit>().copyToClipboard(text),
                child: const Icon(
                  Icons.content_copy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
