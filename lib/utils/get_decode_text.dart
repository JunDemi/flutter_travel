import 'package:html/parser.dart' as html_parser;

String getDecodeText(String text) {
  final String decodedText =
      html_parser.parse(text).documentElement?.text ?? '';
  return decodedText;
}
