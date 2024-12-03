import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_dropdown_widget.dart';
import 'package:soundmind_therapist/core/widgets/custom_shimmer.dart';
import 'package:soundmind_therapist/core/widgets/error_screen.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/create_referral/create_referral_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referral_instituitions/get_referral_institutions_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/widgets/notes.dart';
import 'package:soundmind_therapist/features/patient/presentation/widgets/referralls.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({super.key, required this.id});
  final String id;
  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<GetPatientDetailsCubit>()
        .fetchPatientDetails(int.parse(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetPatientDetailsCubit, GetPatientDetailsState>(
        builder: (context, state) {
          if (state is GetPatientDetailsSuccess) {
            var patient = state.patient;
            return Column(
              children: [
                Container(
                  color: context.secondaryColor.withOpacity(.5),
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        leading: BackButton(
                          color: context.colors.black,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${patient.firstName} ${patient.lastName}",
                            style: context.textTheme.displayMedium?.copyWith(),
                          ),
                          Row(
                            children: [
                              Text("${patient.age}yrs"),
                              Gap(4),
                              Container(
                                height: 20,
                                color: context.colors.white,
                                width: 2,
                              ),
                              Gap(4),
                              Assets.application.assets.svgs.star
                                  .svg(width: 15, height: 15),
                              Gap(2),
                              Text("${(patient.rating)}")
                            ],
                          )
                        ],
                      ).withCustomPadding(),
                      const Gap(20),
                      Row(
                        children: [
                          CustomButton(
                            label: "",
                            height: 40,
                            onPressed: () {},
                            titleWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.message,
                                  color: context.colors.white,
                                ),
                                const Gap(5),
                                Text(
                                  "Message Patient",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ).withExpanded(flex: 3),
                          Gap(10),
                          CustomButton(
                            height: 40,
                            label: "",
                            color: context.secondaryColor,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReferPatientDialod(
                                  id: widget.id,
                                ),
                              );
                            },
                            titleWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_rounded,
                                  color: context.primaryColor,
                                ),
                                const Gap(5),
                                Text(
                                  "Refer",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ).withExpanded(flex: 2),
                        ],
                      ).withCustomPadding(),
                      const Gap(10),
                    ],
                  ),
                ),
                const Gap(10),
                PatientDetails(
                  id: widget.id,
                ).withExpanded(),
              ],
            );
          } else if (state is GetPatientDetailsLoading) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFF3EEFA),
                leadingWidth: 30,
                leading: BackButton(
                  color: context.colors.black,
                ),
              ),
              body: ComplexShimmer.therapistProfileShimmer(context),
            );
          } else if (state is GetPatientDetailsError) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFFF3EEFA),
                  leadingWidth: 30,
                  leading: BackButton(
                    color: context.colors.black,
                  ),
                ),
                body: CustomErrorScreen(
                  onTap: () {},
                  message: state.message,
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ReferPatientDialod extends StatefulWidget {
  const ReferPatientDialod({super.key, required this.id});
  final String id;
  @override
  State<ReferPatientDialod> createState() => _ReferPatientDialodState();
}

class _ReferPatientDialodState extends State<ReferPatientDialod> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetReferralInstitutionsCubit>().fetchInstitutions();
  }

  int instituite = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Refer Patient to"),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            BlocBuilder<GetReferralInstitutionsCubit,
                GetReferralInstitutionsState>(
              builder: (context, state) {
                if (state is GetReferralInstitutionsSuccess) {
                  return CustomDropdown(
                    items: state.institutions,
                    title: "Hospital or Pharmacy ",
                    hintText: "Select an Institute",
                    itemToString: (text) => text.name,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          instituite = value.id;
                        });
                      }
                    },
                  );
                } else {
                  return CustomDropdown(
                    items: [],
                    title: "Hospital",
                    hintText: "Select a Hospital",
                    itemToString: (text) => text,
                    onChanged: (value) {},
                  );
                }
              },
            ),
            const Gap(20),
            BlocConsumer<CreateReferralCubit, CreateReferralState>(
              listener: (context, state) {
                if (state is CreateReferralSuccess) {
                  context.read<GetPatientDetailsCubit>().fetchPatientDetails(
                        int.parse(widget.id),
                      );
                  context.pop();
                }
                if (state is CreateReferralError) {
                  context.showSnackBar(state.message);
                  context.pop();
                }
              },
              builder: (context, state) {
                return CustomButton(
                  label: "Done",
                  notifier: ValueNotifier(state is CreateReferralLoading),
                  onPressed: () {
                    context.read<CreateReferralCubit>().createReferral(
                          patientId: int.parse(widget.id),
                          institutionId: instituite,
                          notes: 0.toString(),
                        );
                  },
                );
              },
            ),
          ],
        ).withCustomPadding(),
      ),
    );
  }
}

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key, required this.id});
  final String id;
  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              labelColor: context.primaryColor,
              indicatorColor: context.primaryColor,
              unselectedLabelColor: context.colors.black,
              tabs: const [
                // Tab(text: 'Patients Info'),
                Tab(text: 'Notes'),
                Tab(text: 'Referrals'),
              ],
            ),
            Builder(builder: (context) {
              return TabBarView(
                children: [
                  // PatientsInfo(),
                  NotesWidget(
                    id: widget.id,
                  ),
                  const ReferralWidget(),
                ],
              ).withCustomPadding().withExpanded();
            }),
          ],
        ),
      ),
    );
  }
}
