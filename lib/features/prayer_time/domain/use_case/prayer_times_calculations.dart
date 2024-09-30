import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:fazakir/core/location/location.dart';
import 'package:fazakir/core/notification/notification.dart';
import 'package:fazakir/features/prayer_time/data/models/adhantimes/adhantimes_model.dart';

class PrayerTimesCalculations {
  Future<AdhanTimesModel> getAdhansOfASpecificDay({
    required int year,
    required int month,
    required int day,
  }) async {
    final position = await Location.getPosition();
    final userPosition = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    params.method = CalculationMethod.egyptian;
    final DateComponents date = DateComponents(year, month, day);
    final prayerTimes = PrayerTimes(userPosition, date, params);

    return AdhanTimesModel(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }

  Future<AdhanTimesModel> getAdhansOfTheDay() async {
    final position = await Location.getPosition();
    final userPosition = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.hanafi;
    params.method = CalculationMethod.egyptian;
    final prayerTimes = PrayerTimes.today(userPosition, params);

    return AdhanTimesModel(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }

  Future setNotificationAdhansOfTheDay() async {
    final adhansTimes = await getAdhansOfTheDay();
    NotificationService.sendScheduleNotification(
      id: adhansTimes.fajr.hashCode,
      title: "أذان الفجر",
      body: adhansTimes.fajr.toString(),
      hour: adhansTimes.fajr.hour,
      minute: adhansTimes.fajr.minute,
      second: adhansTimes.fajr.second,
    );
    NotificationService.sendScheduleNotification(
      id: adhansTimes.sunrise.hashCode,
      title: "أذان الشروق",
      body: adhansTimes.sunrise.toString(),
      hour: adhansTimes.sunrise.hour,
      minute: adhansTimes.sunrise.minute,
      second: adhansTimes.sunrise.second,
    );
    NotificationService.sendScheduleNotification(
      id: adhansTimes.dhuhr.hashCode,
      title: "أذان الظهر",
      body: adhansTimes.dhuhr.toString(),
      hour: adhansTimes.dhuhr.hour,
      minute: adhansTimes.dhuhr.minute,
      second: adhansTimes.dhuhr.second,
    );
    NotificationService.sendScheduleNotification(
      id: adhansTimes.asr.hashCode,
      title: "أذان العصر",
      body: adhansTimes.asr.toString(),
      hour: adhansTimes.asr.hour,
      minute: adhansTimes.asr.minute,
      second: adhansTimes.asr.second,
    );
    NotificationService.sendScheduleNotification(
      id: adhansTimes.maghrib.hashCode,
      title: "أذان المغرب",
      body: adhansTimes.maghrib.toString(),
      hour: adhansTimes.maghrib.hour,
      minute: adhansTimes.maghrib.minute,
      second: adhansTimes.maghrib.second,
    );
    NotificationService.sendScheduleNotification(
      id: adhansTimes.isha.hashCode,
      title: "أذان العشاء",
      body: adhansTimes.isha.toString(),
      hour: adhansTimes.isha.hour,
      minute: adhansTimes.isha.minute,
      second: adhansTimes.isha.second,
    );
    log("done");
  }
}
