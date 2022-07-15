part of '../convert_link_screen.dart';

class _TextFieldUserInput extends StatefulWidget {
  const _TextFieldUserInput();

  @override
  State<_TextFieldUserInput> createState() => _TextFieldUserInputState();
}

class _TextFieldUserInputState extends State<_TextFieldUserInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConvertLinkCubit, ConvertLinkState>(
      listenWhen: _checkListenCondition,
      listener: (_, state) => _controller.text = state.userInput,
      builder: (context, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AutoSizeTextField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            readOnly: GoRouter.of(context).location != AppPage.convert.path,
            controller: _controller,
            cursorColor: Colors.black54,
            maxLines: null,
            minFontSize: 20,
            autocorrect: false,
            maxFontSize: 30,
            onChanged: context.read<ConvertLinkCubit>().changeTextField,
            onSubmitted: (value) => context.read<ConvertLinkCubit>().onSave(),
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 30,
              ),
              hintText: 'Nhập văn bản',
            ),
          ),
        );
      },
    );
  }

  /// Return [true] if the user pastes data or deletes all data.
  bool _checkListenCondition(
    ConvertLinkState previous,
    ConvertLinkState current,
  ) {
    final preInput = previous.userInput;
    final curInput = current.userInput;

    final copyAction = preInput.isEmpty && curInput.isNotEmpty;
    final clearAction = preInput.isNotEmpty && curInput.isEmpty;

    return copyAction || clearAction;
  }
}
