part of 'config.dart';

enum CastType {
  string('string'),
  boolean('boolean'),
  double('double'),
  int('int');

  final String type;

  const CastType(this.type);
}
