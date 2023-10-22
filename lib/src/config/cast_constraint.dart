part of 'config.dart';

@immutable
final class CastConstraint {
  final String name;
  final Map<String, dynamic> rules;

  const CastConstraint({required this.name, required this.rules});
}
