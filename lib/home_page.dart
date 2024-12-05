import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:simple_remainder_app/constants/text_constants.dart';
import 'package:simple_remainder_app/models/reminder_model.dart';
import 'package:simple_remainder_app/utils/reminder_service.dart';
import 'package:simple_remainder_app/widgets/add_reminder_dialog.dart';
import 'package:simple_remainder_app/widgets/custom_appbar.dart';
import 'package:simple_remainder_app/widgets/custom_navbar.dart';
import 'package:simple_remainder_app/widgets/reminder_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  void onTapBottomNavBar(value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: onTapBottomNavBar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showAddReminderDialog(context: context);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Symbols.add_rounded,
          color: Colors.black,
          size: 30,
          weight: 600,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ReminderModel>('reminders').listenable(),
        builder: (context, Box<ReminderModel> box, _) {
          final reminders = ReminderService.getReminders();
          final List<ReminderModel> filteredReminders;
          if (currentIndex == 0) {
            filteredReminders =
                reminders.where((reminder) => !reminder.isCompleted).toList();
            if (filteredReminders.isEmpty) {
              return noPendingReminders(
                title: TextConstants.noPendingRemindersTitle,
                icon: Symbols.pending_rounded,
              );
            }
          } else {
            filteredReminders =
                reminders.where((reminder) => reminder.isCompleted).toList();
            if (filteredReminders.isEmpty) {
              return noPendingReminders(
                title: TextConstants.noCompletedRemindersTitle,
                icon: Symbols.check_circle_rounded,
              );
            }
          }

          return ListView.builder(
            itemCount: filteredReminders.length,
            itemBuilder: (context, index) {
              final ReminderModel reminder = filteredReminders[index];
              return ReminderWidget(reminder: reminder);
            },
          );
        },
      ),
    );
  }

  Widget noPendingReminders({required String title, required IconData icon}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 200,
            weight: 500,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
