part of 'convert_link_cubit.dart';

class ConvertLinkState extends Equatable {
  const ConvertLinkState({
    this.userInput = '',
    this.type = ConvertType.none,
    this.originalUrl = const [],
    this.convertLink = const [],
  });

  final String userInput;
  final ConvertType type;
  final List<String> originalUrl;
  final List<String> convertLink;

  @override
  List<Object> get props => [userInput, type, originalUrl, convertLink];
}
