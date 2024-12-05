import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:simple_remainder_app/constants/colors_constants.dart';
import 'package:simple_remainder_app/models/reminder_model.dart';
import 'package:simple_remainder_app/utils/helper_function.dart';
import 'package:simple_remainder_app/utils/reminder_service.dart';
import 'package:simple_remainder_app/widgets/add_reminder_dialog.dart';

class ReminderWidget extends StatelessWidget {
  final ReminderModel reminder;
  const ReminderWidget({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await ReminderService.deleteReminder(reminderId: reminder.id);
            },
            backgroundColor: ColorsConstants.redColor,
            foregroundColor: Colors.white,
            icon: Symbols.delete_rounded,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) async {
              await showUpdateReminderDialog(
                context: context,
                oldReminder: reminder,
              );
            },
            backgroundColor: ColorsConstants.blueColor,
            foregroundColor: Colors.white,
            icon: Symbols.edit_rounded,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.white,
              width: 0.25,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: reminder.isCompleted,
                      splashRadius: 0,
                      onChanged: (value) async {
                        if (value != null) {
                          await ReminderService.toggleCompletion(
                              reminderId: reminder.id);
                        }
                      },
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(color: Colors.white),
                    ),
                    Text(
                      reminder.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: List.generate(reminder.tags.length, (index) {
                      final Tag tag = reminder.tags[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _tagBox(tag: tag, context: context),
                      );
                    }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _tagBox({required Tag tag, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: tag.color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        tag.label,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
