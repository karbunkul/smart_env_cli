import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:mustache_template/mustache.dart';
import 'package:path/path.dart' as p;

part 'cast_constraint.dart';
part 'cast_type.dart';
part 'template.dart';
part 'variable.dart';

@immutable
final class Config {
  final List<Variable> variables;
  final List<VirtualVariable>? virtual;
  final List<BaseTemplate> templates;

  Config({
    required this.variables,
    required this.templates,
    this.virtual,
  });

  double get version => 1.0;

  static Config import(Map<String, dynamic> json) {
    return _ConfigImporter(json).toConfig();
  }
}

@immutable
final class _ConfigImporter {
  final Map<String, dynamic> json;

  const _ConfigImporter(this.json);

  Config toConfig() {
    return Config(
      variables: _variables,
      templates: _templates,
      virtual: _virtual,
    );
  }

  List<VirtualVariable> get _virtual {
    final virtual = <VirtualVariable>[];
    for (final virtualVar in json['virtual'] ?? []) {
      virtual.add(
        VirtualVariable(
          name: virtualVar['name'],
          exec: virtualVar['exec'],
        ),
      );
    }
    return virtual;
  }

  List<BaseTemplate> get _templates {
    final templates = <BaseTemplate>[];
    for (final Map template in json['templates'] ?? []) {
      if (template.containsKey('template')) {
        templates.add(
          FileTemplate(
            output: template['output'],
            template: template['template'],
          ),
        );
      }

      if (template.containsKey('json')) {
        templates.add(
          JsonTemplate(
            output: template['output'],
            fields: (template['json']['fields'] as List).cast<String>(),
          ),
        );
      }
    }

    return templates;
  }

  List<Variable> get _variables {
    final variables = <Variable>[];

    for (final variable in json['variables']) {
      final castTo = variable['castTo'];

      final newCastTo = castTo != null
          ? CastType.import(variable['castTo'])
          : CastType.string;

      final constraint = variable['constraint'];
      CastConstraint? newConstraint;
      if (constraint != null) {
        final constraints = (json['constraints'] as List).firstWhere(
          (e) => e['name'] == constraint,
        );
        newConstraint = CastConstraint(
          name: constraint,
          rules: constraints['rules'],
        );
      }

      final importVar = Variable(
        name: variable['name'],
        castTo: newCastTo,
        constraint: newConstraint,
      );
      variables.add(importVar);
    }

    return variables;
  }
}
