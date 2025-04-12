import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/widgets/custom_shimmer.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointments/get_upcoming_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/views/appointments_tab.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Appointments'),
          title: TabBar(
            labelColor: context.primaryColor,
            indicatorColor: context.primaryColor,
            unselectedLabelColor: context.colors.black,
            tabs: const [
              Tab(text: 'Session'),
              Tab(text: 'Appointments'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UpcomingAppointmentsTab(),
            AcceptedAppointmentsTab(),
          ],
        ),
      ),
    );
  }
}

class UpcomingAppointmentsTab extends StatelessWidget {
  const UpcomingAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<GetUpcomingAppointmentsCubit,
              GetUpcomingAppointmentsState>(
            builder: (context, state) {
              if (state is GetUpcomingAppointmentsSuccess) {
                var appointments = state.appointments;
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    var doc = appointments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.goNamed(Routes.view_sessionName,
                                extra: doc);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: context.screenWidth * .9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: context.primaryColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.profilePicture != null
                                        ? Image.network(
                                            doc.profilePicture!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ).withClip(4)
                                        : Container(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc.patientName,
                                          style: context.textTheme.displayMedium
                                              ?.copyWith(
                                            color: context.colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Gap(15),
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: Colors.purple[900]?.withOpacity(.5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: context.colors.white,
                                          ),
                                          const Gap(5),
                                          Text(
                                            DateFormater.formatTimeRange(
                                                doc.schedule.startTime,
                                                doc.schedule.endTime),
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: context.colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: context.colors.white,
                                          ),
                                          const Gap(5),
                                          Text(
                                            DateFormater.formatDateTime(
                                              doc.booking.date,
                                            ),
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: context.colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              } else if (state is GetUpcomingAppointmentsLoading) {
                return ComplexShimmer.cardShimmer(
                        itemCount: 1,
                        margin: const EdgeInsets.symmetric(vertical: 20))
                    .withCustomPadding();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
