import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mustache_template/mustache.dart';
import 'package:path/path.dart' as p;

final class TemplateResolver {
  final String output;
  final String template;

  final Map<String, dynamic> context;

  const TemplateResolver({
    required this.output,
    required this.template,
    required this.context,
  });

  String apply({String? workDir}) {
    final templateFile = File(p.normalize(p.join(workDir ?? '', template)));

    if (!templateFile.existsSync()) {
      throw Exception('File ${templateFile.absolute.path} not found');
    }

    final tpl = Template(templateFile.readAsStringSync());
    _base64();

    return tpl.renderString(context);
  }

  void _base64() {
    context.putIfAbsent('base64', () {
      return (LambdaContext value) {
        final renderSource = value.renderSource(value.source).trim();
        final bytes = utf8.encode(renderSource);

        final base64 = base64Encode(Uint8List.fromList(bytes));
        return base64;
      };
    });
  }
}
