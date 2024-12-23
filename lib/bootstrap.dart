import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  // - System graphical options -
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      child: HiveWrapper(
        child: await builder(),
      ),
    ),
  );
}
