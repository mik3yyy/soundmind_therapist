import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/schedule.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/therapist_profile/therapist_profile_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/widgets/education_pop_up.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/widgets/schedule_widget.dart';
import 'package:soundmind_therapist/features/wallet/presentation/widgets/succesful.dart';

class PracticeInfoScreen extends StatefulWidget {
  const PracticeInfoScreen({super.key});

  @override
  State<PracticeInfoScreen> createState() => _PracticeInfoScreenState();
}

class _PracticeInfoScreenState extends State<PracticeInfoScreen> with Validators, AutomaticKeepAliveClientMixin {
  final signupForm = GlobalKey<FormState>();

  List<ScheduleTEMP> schedules = [];
  // List<ScheduleTEMP> scheduleTempList = [];
  List<Qualification> qualifications = [];

  @override
  bool get wantKeepAlive => true; // Preserve state
  @override
  Widget build(BuildContext context) {
    super.build(context); // Important!

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            context.pop();
          },
        ),
      ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
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
            label: "Click here to add Schedule",
            onPressed: () {
              setState(() {
                schedules.add(ScheduleTEMP.empty());
              });
            },
            textStyle: context.textTheme.bodyMedium?.copyWith(color: context.primaryColor),
          ),
          Gap(10),
          AutoSizeText(
            "Educational qualifications/Certification ",
            style: context.textTheme.titleLarge,
          ).toRight(),

          Column(
            children: qualifications
                .map<Widget>((qualification) {
                  return Container(
                    // height: 50,
                    width: context.screenWidth * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF1F1F1),
                    ),
                    child: ListTile(
                      title: Text(
                        qualification.schoolName,
                        style: context.textTheme.titleLarge,
                      ),
                      subtitle: Text(qualification.degree),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            qualifications.remove(qualification);
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: context.colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .addSpacer(Gap(10)),
          ),
          CustomTextButton(
            label: "Click here to add Qualification",
            textStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.primaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EducationPopUp(
                  onSubmit: (qualification) {
                    setState(() {
                      qualifications.add(qualification);
                    });
                    context.pop();
                  },
                ),
              );
            },
          ).toRight(),
        ].addSpacer(const Gap(10)),
      ).withSafeArea().withCustomPadding().withForm(signupForm).withScrollView(),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Row(
          children: [
            BlocConsumer<TherapistProfileCubit, TherapistProfileState>(
              listener: (context, state) {
                if (state is TherapistProfileSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // User must tap button to close dialog
                    builder: (BuildContext context) {
                      return SuccessfulWidget(
                        message: "Your practice info has been successfully updated!",
                        onTap: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          context.pop();
                        },
                      );
                    },
                  );
                }
                if (state is TherapistProfileFailue) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  label: "Next",
                  notifier: ValueNotifier(state is TherapistProfileLoading),
                  onPressed: () {
                    if (!signupForm.currentState!.validate()) {
                      return;
                    }
                    for (var s in schedules) {
                      if (!s.isSet()) {
                        context.showSnackBar("Give start and end Date to all your scheule");
                        return;
                      }
                      if (!s.isOkay()) {
                        context.showSnackBar("Start Time should be greater than end time");
                        return;
                      }
                    }
                    List<Schedule> schedules_real = schedules.expand((s) {
                      if (s.dayOfWeek != null && s.dayOfWeek!.isNotEmpty && s.startTime != null && s.endTime != null) {
                        return s.dayOfWeek!.map((d) => Schedule(
                              dayOfWeek: d,
                              startTime: DateFormater.convertTime12hTo24h(s.startTime!)!,
                              endTime: DateFormater.convertTime12hTo24h(s.endTime!)!,
                            ));
                      } else {
                        // Optionally, handle or log invalid ScheduleTEMP instances
                        return const Iterable<Schedule>.empty();
                      }
                    }).toList();

                    print("SCHEDULE: $schedules_real");

                    context.read<TherapistProfileCubit>().uploadPracticeInfo(
                          PracticalInfoModel(
                            schedules: schedules_real,
                            qualifications: qualifications,
                          ),
                        );
                  },
                );
              },
            ).withExpanded(),
          ],
        ).withCustomPadding(),
      ),
    );
  }
}
