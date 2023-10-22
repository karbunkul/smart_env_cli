import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:smart_env/smart_env.dart';

void main(List<String> args) {
  runZonedGuarded(() => SmartEnvRunner().run(args), (error, stack) {
    Logger('smart_env')..severe(error, stack);

    print(stack);

    exit(1);
  });
}
