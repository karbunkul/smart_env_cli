import 'package:smart_env/smart_env.dart';

void main() {
  final variables = <Variable>[
    Variable(
      name: 'port',
      castTo: CastType.int,
      constraint: CastConstraint(
        name: 'port',
        constraints: [
          {'minimum': 80},
          {'maximum': 300},
        ],
      ),
    ),
    Variable(
      name: 'debug_mode',
      castTo: CastType.boolean,
    ),
  ];

  final templates = <Template>[
    Template(output: 'lib', template: 'config.dart'),
  ];

  final config = Config(
    variables: variables,
    templates: templates,
  );

  print(config.export());
}
