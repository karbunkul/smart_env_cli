part of 'config.dart';

@immutable
abstract base class BaseTemplate {
  final String output;

  const BaseTemplate({required this.output});

  String performTemplate({
    required Map<String, dynamic> vars,
    required String workDir,
  });
}

@immutable
final class FileTemplate extends BaseTemplate {
  final String template;

  const FileTemplate({required super.output, required this.template});

  @override
  String performTemplate({
    required Map<String, dynamic> vars,
    required String workDir,
  }) {
    final templateFile = File(p.normalize(p.join(workDir, template)));

    if (!templateFile.existsSync()) {
      throw Exception('File ${templateFile.absolute.path} not found');
    }

    final context = _base64(vars);

    final tpl = Template(
      templateFile.readAsStringSync(),
      htmlEscapeValues: false,
    );

    return tpl.renderString(context);
  }

  Map<String, dynamic> _base64(Map<String, dynamic> vars) {
    final context = Map<String, dynamic>.from(vars);
    context.putIfAbsent('base64', () {
      return (LambdaContext value) {
        final renderSource = value.renderSource(value.source).trim();
        final bytes = utf8.encode(renderSource);

        final base64 = base64Encode(Uint8List.fromList(bytes));
        return base64;
      };
    });

    return context;
  }
}

@immutable
final class JsonTemplate extends BaseTemplate {
  final List<String> fields;

  const JsonTemplate({required super.output, required this.fields});

  @override
  String performTemplate({
    required Map<String, dynamic> vars,
    required String workDir,
  }) {
    final json = <String>[];
    for (final field in fields) {
      final key = field.toLowerCase();
      final raw = vars[key];
      final value = raw is String ? "$raw" : raw;
      json.add('"$key": $value');
    }

    return '{\n  ${json.join(', \n  ')}\n}';
  }
}
