import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'disk_storage_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> diskStorage(_) => SharedPreferences.getInstance();
