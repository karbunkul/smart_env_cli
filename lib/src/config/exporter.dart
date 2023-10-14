part of 'config.dart';

extension ConfigExporter on Config {
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
