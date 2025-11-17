import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_date_picker.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/verify_email.dart';

class EducationPopUp extends StatefulWidget {
  const EducationPopUp({super.key, required this.onSubmit});
  final Function(Qualification qualification) onSubmit;
  @override
  State<EducationPopUp> createState() => _EducationPopUpState();
}

class _EducationPopUpState extends State<EducationPopUp> {
  TextEditingController _instituite = TextEditingController();

  TextEditingController _gradYear = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // height: context.screenHeight * .6,
        width: context.screenWidth * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "New education or certification",
                  style: context.textTheme.titleLarge,
                  minFontSize: 10,
                  maxLines: 1,
                ).withExpanded(),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Assets.application.assets.svgs.cancel.svg(),
                )
              ],
            ),
            CustomTextField(
              titleText: "Institution/ Name",
              controller: _instituite,
              hintText: "E.g Yale University, Google",
            ),
            CustomTextField(
              titleText: "Degree",
              controller: _gradYear,
              hintText: "i.e computer science",
            ),
            CustomDatePicker(
              onDateChanged: (date) {
                setState(() {
                  startDate = date;
                });
              },
              title: "Start Date",
              mode: DatePMode.none,
            ),
            CustomDatePicker(
              onDateChanged: (date) {
                setState(() {
                  endDate = date;
                });
              },
              title: "End Date",
              mode: DatePMode.none,
            ),
            Gap(10),
            CustomButton(
              label: "Save",
              enable: startDate != null && endDate != null && _instituite.text.isNotEmpty && _gradYear.text.isNotEmpty,
              onPressed: () {
                if (endDate!.year < startDate!.year) {
                  context.showSnackBar("End year is meant to be Greater than start year");
                  return;
                }
                String endD = DateFormater.formatDate(endDate!);
                String startD = DateFormater.formatDate(startDate!);
                widget.onSubmit(Qualification(
                    schoolName: _instituite.text, degree: _gradYear.text, startDate: startD, endDate: endD));
              },
            ),
            Gap(20),
          ].addSpacer(const Gap(10)),
        ),
      ),
    );
  }
}
