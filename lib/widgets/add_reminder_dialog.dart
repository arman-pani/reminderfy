import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:simple_remainder_app/constants/colors_constants.dart';
import 'package:simple_remainder_app/constants/text_constants.dart';
import 'package:simple_remainder_app/models/reminder_model.dart';
import 'package:simple_remainder_app/utils/helper_function.dart';
import 'package:simple_remainder_app/utils/reminder_service.dart';
import 'package:simple_remainder_app/widgets/reminder_textfield.dart';

Future<void> showAddReminderDialog({required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AddAndUpdateReminderDialog(isUpdate: false);
    },
  );
}

Future<void> showUpdateReminderDialog({
  required BuildContext context,
  required ReminderModel oldReminder,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AddAndUpdateReminderDialog(
        isUpdate: true,
        oldId: oldReminder.id,
        oldTags: oldReminder.tags,
        oldTitle: oldReminder.title,
      );
    },
  );
}

class AddAndUpdateReminderDialog extends StatefulWidget {
  final String? oldId;
  final String? oldTitle;
  final List<Tag>? oldTags;
  final bool isUpdate;
  const AddAndUpdateReminderDialog({
    super.key,
    this.oldTitle,
    this.oldTags,
    required this.isUpdate,
    this.oldId,
  });

  @override
  State<AddAndUpdateReminderDialog> createState() =>
      _AddAndUpdateReminderDialogState();
}

class _AddAndUpdateReminderDialogState
    extends State<AddAndUpdateReminderDialog> {
  TextEditingController reminderController = TextEditingController();
  late List<Tag> selectedTags;
  @override
  void initState() {
    super.initState();
    selectedTags = widget.oldTags ?? [];
    reminderController.text = widget.oldTitle ?? "";
  }

  void onTagChanged(Tag tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConstants.bottomNavBgColor,
      surfaceTintColor: ColorsConstants.bottomNavBgColor,
      title: Row(
        children: [
          const Icon(
            Symbols.siren,
            size: 25,
            weight: 600,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            TextConstants.addReminderDialogTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            ReminderTextfield(controller: reminderController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Tag.values.map((tag) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _tagBox(
                    tag: tag,
                    context: context,
                    isSelected: selectedTags.contains(tag),
                    onPressed: () => onTagChanged(tag),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel', style: Theme.of(context).textTheme.titleMedium),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(widget.isUpdate ? 'Update' : 'Add',
              style: Theme.of(context).textTheme.titleMedium),
          onPressed: () {
            if (reminderController.text.trim() == "") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(TextConstants.textFieldErrorMessage1),
                ),
              );
            } else {
              if (widget.isUpdate) {
                ReminderService.updateReminder(
                  reminderId: widget.oldId!,
                  title: reminderController.text.trim(),
                  tags: selectedTags,
                );
              } else {
                final ReminderModel reminder = ReminderModel(
                  title: reminderController.text.trim(),
                  isCompleted: false,
                  tags: selectedTags,
                );
                ReminderService.addReminder(reminder);
              }

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.isUpdate
                        ? TextConstants.reminderUpdatedSuccessMessage
                        : TextConstants.reminderAddedSuccessMessage,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _tagBox(
      {required Tag tag,
      required BuildContext context,
      required bool isSelected,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? tag.color.withOpacity(0.7)
              : tag.color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          tag.label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
        ),
      ),
    );
  }
}
