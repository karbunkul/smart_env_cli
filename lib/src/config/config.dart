import 'package:dotenv/dotenv.dart';
import 'package:json_schema/json_schema.dart';
import 'package:meta/meta.dart';

import '../template_resolver/resolver.dart';

part 'cast_constraint.dart';
part 'cast_type.dart';
part 'exporter.dart';
part 'file_template.dart';
part 'generator.dart';
part 'variable.dart';

@immutable
final class Config {
  final List<Variable> variables;
  final String? baseDir;
  final List<FileTemplate> templates;

  Config({
    required this.variables,
    required this.templates,
    this.baseDir,
  });

  double get version => 1.0;
}
