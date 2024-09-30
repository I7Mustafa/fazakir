// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(currentTimeZone);
    tz.setLocalLocation(location);
  }

  static getCurrentMonth() => tz.TZDateTime.now(tz.local).month;

  static getCurrentYear() => tz.TZDateTime.now(tz.local).year;

  static getCurrentDay() => tz.TZDateTime.now(tz.local).day;

  static setTime(int hour, int minute, int second) {
    return tz.TZDateTime.utc(
      getCurrentYear(),
      getCurrentMonth(),
      hour,
      minute,
      second,
    );
  }
}
