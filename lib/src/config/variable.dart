part of 'config.dart';

@immutable
final class Variable {
  final String name;
  final CastType castTo;
  final CastConstraint? constraint;
  final String? summary;

  const Variable({
    required this.name,
    this.castTo = CastType.string,
    this.constraint,
    this.summary,
  });

  bool get hasConstraint => constraint != null;

  Map<String, dynamic> export() {
    final json = <String, dynamic>{
      'name': name.toUpperCase(),
      'castTo': castTo.type,
    };

    if (constraint != null) {
      json.putIfAbsent('constraint', () => constraint!.name);
    }

    if (summary != null) {
      json.putIfAbsent('summary', () => summary);
    }

    return json;
  }
}

@immutable
final class VirtualVariable {
  final String name;
  final String? exec;

  const VirtualVariable({required this.name, required this.exec});

  Map<String, dynamic> export() {
    final json = <String, dynamic>{
      'name': name.toUpperCase(),
      'exec': exec,
    };

    return json;
  }
}
