import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/login/login.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_accepted_request.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_pending_appointment.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_rejected_appointment.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/approve_appointment_request/approve_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/reject_appointment_request/reject_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/widgets/loding.dart';
import 'package:soundmind_therapist/main.dart';

class AcceptedAppointmentsTab extends StatefulWidget {
  const AcceptedAppointmentsTab({super.key});

  @override
  State<AcceptedAppointmentsTab> createState() =>
      _AcceptedAppointmentsTabState();
}

class _AcceptedAppointmentsTabState extends State<AcceptedAppointmentsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetAcceptedAppointmentsCubit>().fetchAcceptedAppointments();
    context.read<GetRejectedAppointmentsCubit>().fetchRejectedAppointments();
    context.read<GetPendingAppointmentsCubit>().fetchPendingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<GetAcceptedAppointmentsCubit>()
            .fetchAcceptedAppointments();
        context
            .read<GetRejectedAppointmentsCubit>()
            .fetchRejectedAppointments();
        context.read<GetPendingAppointmentsCubit>().fetchPendingAppointments();
        Future.delayed(Duration(seconds: 4));
      },
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  // width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.grey[300], // Background color for inactive tabs
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TabBar(
                    labelColor: Colors.white, // Color for the active label
                    indicatorSize: TabBarIndicatorSize.tab,

                    unselectedLabelColor:
                        Colors.grey, // Color for the inactive label
                    indicator: BoxDecoration(
                      color: context.primaryColor, // Color for the active tab
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    tabs: const [
                      Tab(text: 'Requests'),
                      Tab(text: 'Accepted'),
                      Tab(text: 'Declined'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              RequestsTab(),
              AcceptedTab(),
              DeclinedTab(),
            ],
          ).withCustomPadding(),
        ),
      ),
    );
  }
}

class RequestsTab extends StatefulWidget {
  const RequestsTab({super.key});

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RejectAppointmentCubit, RejectAppointmentState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RejectAppointmentSuccess) {
          showDialog(context: context, builder: (context) => LoadingScreen());
        }
        if (state is RejectAppointmentSuccess) {
          context.pop();
          context
              .read<GetAcceptedAppointmentsCubit>()
              .fetchAcceptedAppointments();
          context
              .read<GetRejectedAppointmentsCubit>()
              .fetchRejectedAppointments();
          context
              .read<GetPendingAppointmentsCubit>()
              .fetchPendingAppointments();
        }
        if (state is RejectAppointmentError) {
          context.pop();
        }
      },
      child: BlocListener<ApproveAppointmentCubit, ApproveAppointmentState>(
          listener: (context, state) {
            if (state is ApproveAppointmentLoading) {
              showDialog(
                  context: context, builder: (context) => LoadingScreen());
            }
            if (state is ApproveAppointmentSuccess) {
              context.pop();
              context
                  .read<GetAcceptedAppointmentsCubit>()
                  .fetchAcceptedAppointments();
              context
                  .read<GetRejectedAppointmentsCubit>()
                  .fetchRejectedAppointments();
              context
                  .read<GetPendingAppointmentsCubit>()
                  .fetchPendingAppointments();
            }
            if (state is ApproveAppointmentError) {
              context.pop();
            }
            // TODO: implement listener
          },
          child: BlocConsumer<GetPendingAppointmentsCubit,
              GetPendingAppointmentsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetPendingAppointmentsSuccess) {
                var bookings = state.appointments;
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        var appoitments = bookings[index];
                        return buildAppointmentCard(
                          appointment: appoitments,
                          status: 'Rejected',
                          onTap: () {
                            // Handle request review action here
                          },
                        );
                      },
                    ).withExpanded(),
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}

class AcceptedTab extends StatefulWidget {
  const AcceptedTab({super.key});

  @override
  State<AcceptedTab> createState() => _AcceptedTabState();
}

class _AcceptedTabState extends State<AcceptedTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAcceptedAppointmentsCubit,
        GetAcceptedAppointmentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetAcceptedAppointmentsSuccess) {
          var bookings = state.appointments;
          return Column(
            children: [
              ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var appoitments = bookings[index];
                  return buildAppointmentCard(
                    appointment: appoitments,
                    status: 'Rejected',
                    onTap: () {
                      // Handle request review action here
                    },
                  );
                },
              ).withExpanded(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class DeclinedTab extends StatefulWidget {
  const DeclinedTab({super.key});

  @override
  State<DeclinedTab> createState() => _DeclinedTabState();
}

class _DeclinedTabState extends State<DeclinedTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRejectedAppointmentsCubit,
        GetRejectedAppointmentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetRejectedAppointmentsSuccess) {
          var bookings = state.appointments;
          return Column(
            children: [
              ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var appoitments = bookings[index];
                  return buildAppointmentCard(
                    appointment: appoitments,
                    status: 'Rejected',
                    onTap: () {
                      // Handle request review action here
                    },
                  );
                },
              ).withExpanded(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

Widget buildAppointmentCard({
  required AppointmentModel appointment,
  required VoidCallback onTap,
  required String status,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    imageUrl: appointment.profilePicture ?? ImageUtils.profile),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appointment.patientName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  // Text(appointment.areaOfSpecialization ?? "",
                  //     style: TextStyle(color: Colors.grey[600])),
                  Text("Day: ${appointment.schedule.dayOfWeekTitle}"),
                  Text(
                      "Time: ${DateFormater.formatTimeRange(appointment.schedule.startTime, appointment.schedule.endTime)}"),
                  Text(
                    status,
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(height: 16),
          // CustomButton(label: "", onPressed: onPressed)
          // ElevatedButton.icon(
          //   onPressed: onTap,
          //   icon: Icon(Icons.notifications, color: Colors.purple),
          //   label: Text(actionText, style: TextStyle(color: Colors.purple)),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.purple.withOpacity(0.1),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)),
          //     elevation: 0,
          //   ),
          // ),
        ],
      ),
    ),
  );
}
