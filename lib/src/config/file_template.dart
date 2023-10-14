part of 'config.dart';

@immutable
final class FileTemplate {
  final String output;
  final String template;

  const FileTemplate({required this.output, required this.template});

  Map<String, dynamic> export() {
    return {
      'output': output,
      'template': template,
    };
  }
}
