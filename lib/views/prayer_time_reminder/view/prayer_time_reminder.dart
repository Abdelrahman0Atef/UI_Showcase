part of '../prayer_time_reminder_imports.dart';

class PrayerTimeReminder extends StatefulWidget {
  const PrayerTimeReminder({super.key});

  @override
  State<PrayerTimeReminder> createState() => _PrayerTimeReminderState();
}

class _PrayerTimeReminderState extends State<PrayerTimeReminder> {
  final PrayerTimeReminderViewmodel vm = PrayerTimeReminderViewmodel();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    vm.notificationService.init();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: CustomText(text: MyStrings.prayerReminder),
    ),
    body: Center(
      child: CustomButton(
        onPressed: () async {
          try {
            await vm.scheduleNextPrayerNotificationOnly();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(text: MyStrings.prayerScheduledSuccess),
                ),
              );
            }
          } catch (e) {
            throw Exception(e);
          }
        },
        text: MyStrings.active,
        textColor: MyColors.white,
        color: MyColors.red,
      ),
    ),
  );
}
