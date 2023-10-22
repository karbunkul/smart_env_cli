part of 'config.dart';

@immutable
final class Variable {
  final String name;
  final CastType castTo;
  final CastConstraint? constraint;
  final String? summary;
  final Virtual? virtual;

  const Variable({
    required this.name,
    this.castTo = CastType.string,
    this.constraint,
    this.summary,
    this.virtual,
  });

  bool get hasConstraint => constraint != null;
  bool get isVirtual => virtual != null;

  Object cast(String value) {
    return switch (castTo) {
      CastType.int => int.parse(value),
      CastType.boolean => bool.parse(value),
      CastType.double => double.parse(value),
      CastType.string => value,
    };
  }
}

final class Virtual {
  final String exec;

  Virtual({required this.exec});

  factory Virtual.from(dynamic params) {
    final execField = params['exec'];
    if (execField is String) {
      return Virtual(exec: execField);
    }
    if (execField is Map) {
      final platforms = ['macos', 'linux', 'windows'];

      if (!platforms.contains(Platform.operatingSystem)) {
        throw ArgumentError('virtual must be contains commands for $platforms');
      }

      return Virtual(exec: execField[Platform.operatingSystem]);
    }
    throw UnsupportedError('virtual must be string or map');
  }

  String performExec() {
    final args = exec.split(' ');

    final result = Process.runSync(
      args.first,
      args..removeAt(0),
      runInShell: true,
    );

    return result.stdout.toString().trim();
  }
}
