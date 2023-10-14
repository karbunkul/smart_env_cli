part of 'config.dart';

extension ConfigGenerator on Config {
  void generate() {
    var env = DotEnv(includePlatformEnvironment: true)..load();

    final context = _variables(env);

    for (final fileTemplate in templates) {
      final resolver = TemplateResolver(
        output: fileTemplate.output,
        template: fileTemplate.template,
        context: context,
      );
      print(resolver.apply());
    }
  }

  Map<String, dynamic> _variables(DotEnv env) {
    final result = <String, dynamic>{};

    for (final variable in variables) {
      final key = variable.name.toLowerCase();
      final name = key.toUpperCase();

      result.putIfAbsent(key, () {
        final raw = env.getOrElse(key.toUpperCase(), () {
          throw ArgumentError('Missing value for $name in config');
        });

        if (variable.hasConstraint) {
          final castedValue = switch (variable.castTo) {
            CastType.int => int.parse(raw),
            CastType.boolean => bool.parse(raw),
            CastType.double => double.parse(raw),
            CastType.string => raw,
          };

          var schema = <String, dynamic>{};
          schema.addAll(variable.constraint!.constraints);

          final validated = JsonSchema.create(schema).validate(castedValue);

          if (!validated.isValid) {
            throw validated.errors;
          }

          return castedValue;
        }
        return raw;
      });
    }

    return result;
  }
}
