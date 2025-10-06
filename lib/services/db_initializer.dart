// lib/services/db_initializer.dart
// import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBInitializer {
  static void init() {
    // Mobile (Android/iOS) → sqflite works out of the box
    // Desktop (Windows/Linux/macOS) → must initialize ffi
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }
}
