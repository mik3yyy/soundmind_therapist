import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/utils/constants.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_shimmer.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_button.dart';
import 'package:soundmind_therapist/core/widgets/error_screen.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/approve_appointment_request/approve_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointment_request/get_upcoming_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_upcoming_appointments/get_upcoming_appointments_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/get_user_metrics/get_user_metrics_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/reject_appointment_request/reject_appointment_request_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/widgets/loding.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room/get_user_chat_rooms_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<GetUpcomingAppointmentsCubit>().state;
    var reqState = context.read<GetUpcomingAppointmentRequestCubit>().state;
    var metricState = context.read<GetUserMetricsCubit>().state;
    if (reqState is! GetUpcomingAppointmentRequestSuccess) {
      context
          .read<GetUpcomingAppointmentRequestCubit>()
          .fetchUpcomingAppointmentRequests();
    }
    if (state is! GetUpcomingAppointmentsSuccess) {
      context.read<GetUpcomingAppointmentsCubit>().fetchUpcomingAppointments();
    }
    if (metricState is! GetUserMetricsSuccess) {
      context.read<GetUserMetricsCubit>().fetchUserMetrics();
    }

    var state3 = context.read<GetUserChatRoomsCubit>().state;

    if (state3 is! GetUserChatRoomsSuccess) {
      context.read<GetUserChatRoomsCubit>().fetchChatRooms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetUserMetricsCubit>().fetchUserMetrics();
          context
              .read<GetUpcomingAppointmentsCubit>()
              .fetchUpcomingAppointments();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  var user = (state as UserAccount).userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        // leading: CircleAvatar(
                        //   radius: 30,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(30),
                        // child: CachedNetworkImage(imageUrl: user.),
                        //   ),
                        // ),
                        centerTitle: false,
                        // leadingWidth: 0,
                        titleSpacing: 0,
                        title: Text("Good morning, ${user.firstName}"),
                        actions: [
                          // IconButton(
                          //   onPressed: () {
                          //     // context.goNamed(Routes.notificationName);
                          //   },
                          //   icon: Icon(
                          //     Icons.notifications_outlined,
                          //     color: context.colors.black,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () {
                              context.goNamed(Routes.settingsName);
                            },
                            icon: Icon(
                              Icons.settings_outlined,
                              color: context.colors.black,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<GetUpcomingAppointmentsCubit,
                          GetUpcomingAppointmentsState>(
                        builder: (context, state) {
                          if (state is GetUpcomingAppointmentsSuccess) {
                            var doc = state.appointments;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Upcoming session",
                                  style: context.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                Gap(10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                  style: context
                                                      .textTheme.displayMedium
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
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            color: Colors.purple[900]
                                                ?.withOpacity(.5),
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
                                                    DateFormater
                                                        .formatTimeRange(
                                                            doc.schedule
                                                                .startTime,
                                                            doc.schedule
                                                                .endTime),
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          context.colors.white,
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
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          context.colors.white,
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
                          } else if (state is GetUpcomingAppointmentsLoading) {
                            return ComplexShimmer.cardShimmer(
                                    itemCount: 1,
                                    margin: EdgeInsets.symmetric(vertical: 20))
                                .withCustomPadding();
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const Gap(10),
                      BlocListener<RejectAppointmentCubit,
                              RejectAppointmentState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is RejectAppointmentSuccess) {
                              showDialog(
                                  context: context,
                                  builder: (context) => LoadingScreen());
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
                              context
                                  .read<GetUpcomingAppointmentRequestCubit>()
                                  .fetchUpcomingAppointmentRequests();
                            }
                            if (state is RejectAppointmentError) {
                              context.pop();
                            }
                            // TODO: implement listener
                          },
                          child: BlocListener<ApproveAppointmentCubit,
                                  ApproveAppointmentState>(
                              listener: (context, state) {
                                // TODO: implement listener
                                if (state is ApproveAppointmentLoading) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => LoadingScreen());
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
                                  context
                                      .read<
                                          GetUpcomingAppointmentRequestCubit>()
                                      .fetchUpcomingAppointmentRequests();
                                }
                                if (state is ApproveAppointmentError) {
                                  context.pop();
                                }
                              },
                              child: BlocConsumer<
                                  GetUpcomingAppointmentRequestCubit,
                                  GetUpcomingAppointmentRequestState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  if (state
                                      is GetUpcomingAppointmentRequestSuccess) {
                                    var appointment = state.appointments;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Appointment request",
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const Gap(5),
                                        Container(
                                          width: context.screenWidth * .9,
                                          // height: ,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: context.colors.black,
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                appointment.patientName,
                                                style: context
                                                    .textTheme.displayMedium
                                                    ?.copyWith(
                                                  color: context.colors.white,
                                                ),
                                              ),
                                              const Gap(10),
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormater
                                                        .formatTimeRange(
                                                            appointment.schedule
                                                                .startTime,
                                                            appointment.schedule
                                                                .endTime),
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          context.colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    " | ",
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          context.colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormater.formatDateTime(
                                                        appointment
                                                            .booking.date),
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          context.colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(10),
                                              Row(
                                                children: [
                                                  CustomButton(
                                                    label: "Accept",
                                                    color: context.colors.white,
                                                    textColor:
                                                        context.colors.black,
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              ApproveAppointmentCubit>()
                                                          .approveAppointment(
                                                              appointment
                                                                  .booking.id);
                                                    },
                                                  ).withExpanded(),
                                                  const Gap(10),
                                                  CustomButton(
                                                    label: "Decline",
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              RejectAppointmentCubit>()
                                                          .rejectAppointment(
                                                              appointment
                                                                  .booking.id);
                                                    },
                                                    color:
                                                        const Color(0xFF24262B),
                                                    textColor:
                                                        context.colors.white,
                                                  ).withExpanded(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const Gap(5),
                                      ],
                                    );
                                  } else if (state
                                      is GetUpcomingAppointmentRequestLoading) {
                                    return ComplexShimmer.cardShimmer(
                                            itemCount: 1,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20))
                                        .withCustomPadding();
                                  } else {
                                    return Container();
                                  }
                                },
                              ))),
                      const Gap(10),
                      BlocBuilder<GetUserMetricsCubit, GetUserMetricsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              if (state is GetUserMetricsSuccess) ...[
                                Row(
                                  children: [
                                    Container(
                                      height: 88,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: context.secondaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.metrics.patients.toString(),
                                            style:
                                                context.textTheme.displayMedium,
                                          ),
                                          const Text("Patients")
                                        ],
                                      ),
                                    ).withExpanded(),
                                    const Gap(20),
                                    Container(
                                      height: 88,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: context.secondaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.metrics.appointments
                                                .toString(),
                                            style:
                                                context.textTheme.displayMedium,
                                          ),
                                          const Text("Appointments")
                                        ],
                                      ),
                                    ).withExpanded(),
                                  ],
                                ),
                                Gap(20),
                                Row(
                                  children: [
                                    Container(
                                      height: 88,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: context.secondaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.metrics.reSchedules
                                                .toString(),
                                            style:
                                                context.textTheme.displayMedium,
                                          ),
                                          const Text("Reschedules")
                                        ],
                                      ),
                                    ).withExpanded(),
                                    const Gap(20),
                                    Container(
                                      height: 88,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: context.secondaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.metrics.referredPatients
                                                .toString(),
                                            style:
                                                context.textTheme.displayMedium,
                                          ),
                                          const Text("Referred Patients")
                                        ],
                                      ),
                                    ).withExpanded(),
                                  ],
                                ),
                              ] else if (state
                                  is GetUpcomingAppointmentRequestLoading) ...[
                                ComplexShimmer.cardShimmer(
                                        itemCount: 1,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20))
                                    .withCustomPadding()
                              ] else ...[
                                Container()
                              ],
                              Container(),
                            ],
                          );
                        },
                      ),
                      BlocConsumer<GetUserChatRoomsCubit,
                          GetUserChatRoomsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is GetUserChatRoomsSuccess) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Chats",
                                      style: context.textTheme.displayMedium,
                                    ),
                                    CustomTextButton(
                                      label: "View all",
                                      onPressed: () {
                                        context.goNamed(Routes.patientName);
                                      },
                                    )
                                  ],
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: state.chatRooms.length,
                                  itemBuilder: (context, index) {
                                    var chatRoom = state.chatRooms[index];
                                    return ListTile(
                                      onTap: () {
                                        context.goNamed(
                                          Routes.view_patientName,
                                          extra: chatRoom,
                                          pathParameters: {
                                            'id': chatRoom.receiverID.toString()
                                          },
                                        );
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            context.colors.greyDecor,
                                        child: CachedNetworkImage(
                                          imageUrl: chatRoom.senderProfilePhoto,
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              CachedNetworkImage(
                                                  imageUrl: ImageUtils.profile),
                                        ),
                                      ).withClip(20),
                                      subtitle: Text(
                                        "Tap to open patient",
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            print(chatRoom.receiverID);
                                            print(chatRoom.chatRoomID);
                                            context.goNamed(
                                              Routes.chatRoomName,
                                              extra: chatRoom,
                                              pathParameters: {
                                                'id': chatRoom.chatRoomID
                                                    .toString()
                                              },
                                            );
                                          },
                                          icon: Assets.application.assets.svgs
                                              .therapistMessage
                                              .svg()),
                                      title: Text(chatRoom.senderName),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else if (state is GetUserChatRoomsLoading) {
                            return Container(
                              height: 400,
                              child: ComplexShimmer.listShimmer(itemCount: 7)
                                  .withCustomPadding(),
                            );
                          } else if (state is GetUserChatRoomsError) {
                            return CustomErrorScreen(
                              onTap: () {},
                              message: state.message,
                            );
                          } else {
                            return const Center(
                              child: Text('Welcome to the Patient feature!'),
                            );
                          }
                        },
                      ),
                    ],
                  ).withCustomPadding();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
