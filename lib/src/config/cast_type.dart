part of 'config.dart';

enum CastType {
  string('string'),
  boolean('boolean'),
  double('double'),
  int('int');

  final String type;

  const CastType(this.type);

  CastType import(String type) {
    return CastType.values.firstWhere(
      (element) => element.type == type,
      orElse: () {
        final availableValues = CastType.values.map((e) => e.type).join(', ');
        throw ArgumentError('Available values: $availableValues');
      },
    );
  }
}
