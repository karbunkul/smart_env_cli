part of 'config.dart';

@immutable
final class Template {
  final String output;
  final String template;

  const Template({required this.output, required this.template});

  Map<String, dynamic> export() {
    return {
      'output': output,
      'template': template,
    };
  }
}
