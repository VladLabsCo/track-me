import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'ongoing_channel',
        channelName: 'Ongoing Notifications',
        channelDescription: 'Notifications that cannot be dismissed',
        importance: NotificationImportance.Max,
        channelShowBadge: false,
        enableVibration: false,
        onlyAlertOnce: true,
        playSound: false,
        locked: true,
      ),
    ],
  );

  // - System graphical options -
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
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
