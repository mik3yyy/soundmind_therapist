import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/schedule.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/widgets/schedule_widget.dart';

class PracticeInfoScreen extends StatefulWidget {
  const PracticeInfoScreen({super.key});

  @override
  State<PracticeInfoScreen> createState() => _PracticeInfoScreenState();
}

class _PracticeInfoScreenState extends State<PracticeInfoScreen>
    with Validators {
  final signupForm = GlobalKey<FormState>();
  TextEditingController _practiceName = TextEditingController();
  TextEditingController _rate = TextEditingController();
  List<ScheduleTEMP> schedules = [];
  // List<ScheduleTEMP> scheduleTempList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Practice Information",
                style: context.textTheme.displayMedium,
              ),
              Text(
                "Your personal information is required to help get define a base to your profile information",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          CustomTextField(
            controller: _practiceName,
            hintText: "Enter your  address",
            titleText: "Practice Address",
            validator: validateField,
            onChanged: (valur) {
              setState(() {});
            },
          ),
          // SizedBox(
          //   height: 200,
          //   child: ListView.builder(
          //     physics: AlwaysScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return Dismissible(
          //         key: UniqueKey(),
          //         direction: DismissDirection.endToStart,
          //         background: Container(
          //           alignment: Alignment.centerRight,
          //           padding: EdgeInsets.symmetric(horizontal: 20),
          //           color: Colors.red,
          //           child: Icon(Icons.delete, color: Colors.white),
          //         ),
          //         onDismissed: (direction) {
          //           setState(() {
          //             schedules.removeAt(index);
          //           });
          //         },
          //         child: ScheduleWidget(
          //           scheduleTemp: schedules[index],
          //           title: "Schedule ${index + 1}",
          //           onDelete: () {
          //             setState(() {
          //               schedules.removeAt(index);
          //             });
          //           },
          //           onScheduleChanged: (scheduleTemp) {
          //             setState(() {
          //               schedules[index] = scheduleTemp;
          //             });
          //           },
          //         ),
          //       );
          //     },
          //     itemCount: schedules.length,
          //   ),
          // ),

          Column(
            children: schedules
                .asMap()
                .entries
                .map<Widget>((entry) {
                  int index = entry.key;
                  ScheduleTEMP schedule = entry.value;
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        schedules.removeAt(index);
                      });
                    },
                    child: ScheduleWidget(
                      scheduleTemp: schedule,
                      title: "Schedule ${index + 1}",
                      onDelete: () {
                        setState(() {
                          schedules.removeAt(index);
                        });
                      },
                      onScheduleChanged: (scheduleTemp) {
                        setState(() {
                          schedules[index] = scheduleTemp;
                        });
                      },
                    ),
                  );
                })
                .toList()
                .addSpacer(const Gap(10)),
          ),

          CustomTextButton(
            label: "Add new",
            onPressed: () {
              setState(() {
                schedules.add(ScheduleTEMP.empty());
              });
            },
            textStyle: context.textTheme.bodyMedium
                ?.copyWith(color: context.primaryColor),
          ),
          CustomTextField(
            controller: _rate,
            titleText: "Rate/hr",
            hintText: "e.g \$60",
            validator: validateNumber,
            keyboardType: TextInputType.number,
            onChanged: (valur) {
              setState(() {});
            },
          ),
        ].addSpacer(const Gap(10)),
      )
          .withSafeArea()
          .withCustomPadding()
          .withForm(signupForm)
          .withScrollView(),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: CustomButton(
          label: "Next",
          enable: _rate.text.isNotEmpty && _practiceName.text.isNotEmpty,
          onPressed: () {
            if (!signupForm.currentState!.validate()) {
              return;
            }
            for (var s in schedules) {
              if (!s.isSet()) {
                context.showSnackBar(
                    "Give start and end Date to all your scheule");
                return;
              }
              if (!s.isOkay()) {
                context
                    .showSnackBar("Start Time should be greater than end time");
                return;
              }
            }
            List<Schedule> schedules_real = [];
            for (var s in schedules) {
              print(s.toString());
              s.dayOfWeek!.map((d) => schedules_real.add(Schedule(
                  dayOfWeek: d, startTime: s.startTime!, endTime: s.endTime!)));
            }

            var state = context.read<AuthenticationBloc>().state
                as ProfessionalInfoState;
            context.read<AuthenticationBloc>().add(
                  PracticalInfoEvent(
                    personalInfoModel: state.personalInfoModel,
                    professionalInfoModel: state.professionalInfoModel,
                    practicalInfoModel: PracticalInfoModel(
                      practiceAddress: _practiceName.text,
                      schedules: schedules_real,
                      consultationRate: int.parse(_rate.text),
                    ),
                  ),
                );
          },
        ).toCenter(),
      ),
    );
  }
}
