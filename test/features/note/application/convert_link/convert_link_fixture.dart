part of 'convert_link_test.dart';

final _listData = List.generate(
  content.length,
  (index) => NoteDetail(
    id: index.toString(),
    content: content[index],
    createAt: DateTime.now(),
  ),
);

final content = [
  'https://docs(.)flutter(.)dev/development/tools/sdk/releases?tab=macos',
  'Bit.ly /fadfakrqoorr',
  'I am attempting to remove all white spaces from a string using Dart and Regexp. Given the following string: "test test1 test2" I would want to get: "testtest1test2". I have read some examples in javascript but they do not seem to work in Dart. These are some attempts so far: https://docs(.)flutter.dev/development/tools/sdk/releases?tab=macos. I am attempting to remove all white spaces from a string using Dart and Regexp. Given the following string: "test test1 test2" I would want to get: "testtest1test2". I have read some examples in javascript but they do not seem to work in Dart. These are some attempts so far:',
  '''
      Mảketing: +100
      P/S: Nhiều bác muốn xin vid thì copy link https://vm.tiktk.com/ZS42DD5yL/ rồi lên snaptik tải nha
  ''',
  '''
    Thím thử vào diễn đàn 68747470733A2F2F766F7A2E766E2F thử xem nào. Biết đâu lại gặp 6D6B796F6E672E636F6D
  ''',
  '''
    Cho em xin vài link tele chất lượng đi các bácmới tạo quả account mà trống trải quá
    Thôi thì cũng biếu các bác cái link
    https://t.me/    tf25121yclub
  ''',
];
