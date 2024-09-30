import 'dart:io';

import 'package:flutter/foundation.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    // final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static getCurrentMonth() {
    return tz.TZDateTime.now(tz.local).month;
  }

  static getCurrentYear() {
    return tz.TZDateTime.now(tz.local).year;
  }

  static getCurrentDay() {
    return tz.TZDateTime.now(tz.local).day;
  }

  static setTime({
    required int hour,
    required int minute,
    required int second,
  }) {
    return tz.TZDateTime.utc(
      getCurrentYear(),
      getCurrentMonth(),
      hour,
      minute,
      second,
    );
  }
}
