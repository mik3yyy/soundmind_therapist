import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/string_extension.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/schedule.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({
    Key? key,
    required this.title,
    required this.scheduleTemp,
    required this.onDelete,
    required this.onScheduleChanged,
  }) : super(key: key);

  final String title;
  final ScheduleTEMP scheduleTemp;
  final VoidCallback onDelete;
  final Function(ScheduleTEMP) onScheduleChanged;

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  List<String> dayOfWeek = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  late List<int> days;
  String? startTime;
  String? endTime;

  @override
  void initState() {
    super.initState();
    days = widget.scheduleTemp.dayOfWeek ?? [];
    startTime = widget.scheduleTemp.startTime;
    endTime = widget.scheduleTemp.endTime;
  }

  void _updateSchedule() {
    widget.onScheduleChanged(
        ScheduleTEMP(dayOfWeek: days, startTime: startTime, endTime: endTime));
    // widget.scheduleTemp.dayOfWeek = days;
    // widget.scheduleTemp.startTime = startTime;
    // widget.scheduleTemp.endTime = endTime;
    // widget.onScheduleChanged(widget.scheduleTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.greyDecor),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          // Title and Delete Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: widget.onDelete,
                icon: Assets.application.assets.svgs.cancel.svg(),
              ),
            ],
          ),
          // Time Pickers
          Row(
            children: [
              // Start Time Picker
              _buildTimePicker(
                context,
                label: startTime ?? "Start time",
                onTimeSelected: (selectedTime) {
                  setState(() {
                    startTime = selectedTime;
                  });
                  _updateSchedule();
                },
              ),
              const Gap(5),
              Column(
                children: [
                  Container(
                    height: 1,
                    width: 5,
                    color: context.colors.black,
                  ),
                ],
              ),
              const Gap(5),
              // End Time Picker
              _buildTimePicker(
                context,
                label: endTime ?? "End Time",
                onTimeSelected: (selectedTime) {
                  setState(() {
                    endTime = selectedTime;
                  });
                  _updateSchedule();
                },
              ),
            ],
          ),
          const Gap(10),
          // Day Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayOfWeek.map<Widget>((day) {
              int dayIndex = dayOfWeek.indexOf(day);
              bool isSelected = days.contains(dayIndex);
              return CircleAvatar(
                radius: 20,
                foregroundColor: isSelected
                    ? context.colors.white
                    : context.colors.black.withOpacity(.5),
                backgroundColor: isSelected
                    ? context.primaryColor
                    : context.colors.greyDecorDark,
                child: Text(day).toCenter(),
              ).withOnTap(
                () {
                  setState(() {
                    if (isSelected) {
                      days.remove(dayIndex);
                    } else {
                      days.add(dayIndex);
                    }
                    _updateSchedule();
                  });
                },
              );
            }).toList(),
          ),
          const Gap(5),
        ].addSpacer(Gap(10)),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context,
      {required String label, required Function(String) onTimeSelected}) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.greyDecorDark,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Icon(Icons.timer),
        ],
      ),
    ).withOnTap(() async {
      DateTime? dateTime = await showOmniDateTimePicker(
        context: context,
        type: OmniDateTimePickerType.time,
      );
      if (dateTime != null) {
        String formattedTime = DateFormater.formatTime(dateTime);
        onTimeSelected(formattedTime);
      }
    }).withExpanded();
  }
}
