import 'package:meta/meta.dart';

part 'cast_constraint.dart';
part 'cast_type.dart';
part 'file_template.dart';
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

  Map<String, dynamic> export() {
    final constraints = <Map<String, dynamic>>[];

    final json = <String, dynamic>{
      'version': version,
      'variables': variables.map((e) {
        if (e.constraint != null) {
          constraints.add(e.constraint!.export());
        }

        return e.export();
      }).toList(growable: false),
      'templates': templates.map((e) => e.export()).toList(growable: false),
    };

    if (baseDir != null) {
      json.putIfAbsent('baseDir', () => baseDir);
    }

    if (constraints.isNotEmpty) {
      json.putIfAbsent(
        'constraints',
        () => constraints.toList(growable: false),
      );
    }

    return json;
  }
}
