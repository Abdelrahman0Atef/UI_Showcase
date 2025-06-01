part of '../prayer_time_reminder_imports.dart';

class PrayerTimeReminderViewmodel {
  final NotificationService notificationService = NotificationService();

  final Map<String, String> _prayerSpecificSounds = {
    'الفجر': 'fajr',
    'الظهر': 'dhuhr',
    'العصر': 'asr',
    'المغرب': 'maghrib',
    'العشاء': 'isha',
  };

  Future<(Coordinates?, tz.Location?)> _getCurrentLocationAndZone() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception();
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final coordinates = Coordinates(position.latitude, position.longitude);

    tz.initializeTimeZones();
    final location = tz.local;
    debugPrint(
      'Coordinates: ${coordinates.latitude}, ${coordinates.longitude}',
    );

    return (coordinates, location);
  }

  Future<void> scheduleNextPrayerNotificationOnly() async {
    try {
      final (coordinates, location) = await _getCurrentLocationAndZone();
      if (coordinates == null || location == null) return;

      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final date = DateComponents.from(DateTime.now());
      final prayerTimes = PrayerTimes(coordinates, date, params);
      final tzNow = tz.TZDateTime.now(location);

      final prayers = {
        'الفجر': prayerTimes.fajr,
        'الظهر': prayerTimes.dhuhr,
        'العصر': prayerTimes.asr,
        'المغرب': prayerTimes.maghrib,
        'العشاء': prayerTimes.isha,
      };

      final int id = 0;

      for (final entry in prayers.entries) {
        final prayerName = entry.key;
        final originalTime = tz.TZDateTime.from(entry.value, location);

        if (originalTime.isAfter(tzNow)) {
          final isTooClose = originalTime.difference(tzNow).inMinutes < 2;
          final scheduledDate =
              isTooClose ? tzNow.add(const Duration(minutes: 1)) : originalTime;

          final fallbackSound =
              MyAssets.availableSounds.isNotEmpty
                  ? MyAssets.availableSounds[id %
                      MyAssets.availableSounds.length]
                  : 'default_notification';

          final soundForPrayer =
              _prayerSpecificSounds[prayerName] ?? fallbackSound;

          await notificationService.schedulePrayerNotification(
            id: id,
            title: '${MyStrings.prayerTime} $prayerName',
            body: '${MyStrings.timeToPray} $prayerName',
            dateTime: scheduledDate,
            soundFileName: soundForPrayer,
          );
          break;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
