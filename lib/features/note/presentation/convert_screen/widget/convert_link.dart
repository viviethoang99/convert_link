part of '../convert_link_screen.dart';

class ConvertLink extends StatelessWidget {
  const ConvertLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ConvertLinkCubit, ConvertLinkState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AppBar(),
              const _TextFieldUserInput(),
              const SizedBox(height: 30),
              state.userInput.isEmpty
                  ? const _ButtonWidget()
                  : const SizedBox.shrink(),
              state.originalUrl.isNotEmpty
                  ? const _TitleWidget(
                      title: 'Đường dẫn gốc:',
                    )
                  : const SizedBox.shrink(),
              const _ListUrlWidget(
                type: ConvertType.original,
              ),
              state.originalUrl.isNotEmpty
                  ? const _TitleWidget(
                      title: 'Đường dẫn mã hoá:',
                    )
                  : const SizedBox.shrink(),
              const _ListUrlWidget(
                type: ConvertType.hex,
              ),
              const SizedBox(height: 10),
              const _ListUrlWidget(
                type: ConvertType.addSpace,
              ),
              const SizedBox(height: 10),
              const _ListUrlWidget(
                type: ConvertType.addCharacter,
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.content_paste,
          color: Colors.white,
        ),
        onPressed: context.read<ConvertLinkCubit>().getDataFromClipboard,
        label: const Text(
          'Dán',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 93, 64, 60),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ConvertLinkCubit, ConvertLinkState, String>(
      selector: (state) => state.userInput,
      builder: (context, userInput) {
        if (userInput.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 10,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
