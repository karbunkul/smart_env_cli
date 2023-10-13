part of 'config.dart';

@immutable
final class Variable {
  final String name;
  final CastType castTo;
  final CastConstraint? constraint;

  const Variable({
    required this.name,
    this.castTo = CastType.string,
    this.constraint,
  });

  Map<String, dynamic> export() {
    final json = <String, dynamic>{
      'name': name.toUpperCase(),
      'castTo': castTo.type,
    };

    if (constraint != null) {
      json.putIfAbsent('constraint', () => constraint!.name);
    }

    return json;
  }
}
