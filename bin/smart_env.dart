import 'package:smart_env/smart_env.dart';

void main() {
  final variables = <Variable>[
    Variable(
      name: 'port',
      castTo: CastType.int,
      constraint: CastConstraint(
        name: 'port',
        constraints: {'minimum': 80, 'maximum': 300},
      ),
    ),
    Variable(name: 'debug_mode', castTo: CastType.boolean),
    Variable(name: 'base_auth'),
  ];

  final templates = <FileTemplate>[
    FileTemplate(output: 'lib/config.dart', template: 'config.tpl'),
  ];

  final config = Config(
    variables: variables,
    templates: templates,
  );

  config.generate();
}
