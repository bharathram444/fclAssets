import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/app.dart';
import 'bootstrap.dart';

/// Read and complete this steps before running app
/// Step 1 : Convert every relative import to package import...
/// Step 2 : Add real [Urls] at lib/core/consts/urls.dart in [Urls.uat] and [Urls.local] factory's
/// Step 3 : Run: flutter pub get && flutter pub run flutter_launcher_icons and Delete [/android/app/src/main/res/minmap-anydpi-v26]
///          To get icon for app ok.

Future<void> main() async => bootstrap(() {
      final container = ProviderContainer();
      runApp(
          UncontrolledProviderScope(container: container, child: const App()));
    });
 