part of 'config.dart';

@immutable
final class CastConstraint {
  final String name;
  final Map<String, dynamic> constraints;

  const CastConstraint({required this.name, required this.constraints});

  Map<String, dynamic> export() {
    return <String, dynamic>{
      'name': name,
      'constraints': constraints,
    };
  }
}
