import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() => integrationDriver(
  onScreenshot: (name, bytes, [_]) async {
    final folder = Directory(
      Platform.environment['WATCHLIST_SCREENSHOTS'] ?? 'build/screenshots',
    );
    await folder.create(recursive: true);
    await File('${folder.path}/$name.png').writeAsBytes(bytes);
    return true;
  },
);
