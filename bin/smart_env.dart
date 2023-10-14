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

  final templates = <FileTemplate>[
    FileTemplate(output: 'lib/config.dart', template: 'config.tpl'),
  ];

  final config = Config(
    variables: variables,
    templates: templates,
  );

  final fileTemplate = config.templates.first;
  final resolver = TemplateResolver(
      output: fileTemplate.output,
      template: fileTemplate.template,
      context: {
        'port': 80,
        'base_auth': 'very-secret',
        'debug_mode': false,
      });

  print(resolver.apply());
}
