import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/core/utils/image_util.dart';
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
import 'package:sound_mind/core/widgets/error_screen.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/upcoming_appointment/upcoming_appointment_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/views/appointment_page.dart';
import 'package:sound_mind/features/chat/presentation/blocs/get_user_chat_rooms/get_user_chat_rooms_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<GetUserChatRoomsCubit>().state;

    if (state is! GetUserChatRoomsLoaded) {
      context.read<GetUserChatRoomsCubit>().fetchUserChatRooms();
    }
  }

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
              Tab(text: 'Calendar'),
              Tab(text: 'Chat'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CalendarScreen(),
            ChatMainScreen(),
          ],
        ),
      ),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<UpcomingAppointmentCubit, UpcomingAppointmentState>(
            builder: (context, state) {
              if (state is UpcomingAppointmentsLoaded) {
                var doc = state.upcomingAppointments[0];
                print("DATA: ${doc}");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.goNamed(Routes.viewSessionName, extra: doc);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
                                CachedNetworkImage(
                                  imageUrl:
                                      doc.profilePicture ?? ImageUtils.profile,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).withClip(4),
                                const Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      doc.therapistName,
                                      style: context.textTheme.displayMedium
                                          ?.copyWith(
                                        color: context.colors.white,
                                      ),
                                    ),
                                    AutoSizeText(
                                      doc.areaOfSpecialization ?? "",
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: context.colors.white),
                                    ),
                                    Text(
                                      "Google Meet",
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                        color: context.colors.white,
                                      ),
                                    )
                                  ],
                                ).withExpanded()
                              ],
                            ),
                            Gap(10),
                            Container(
                              height: 40,
                              padding: const EdgeInsets.all(10),
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
                ).withCustomPadding();
              } else if (state is UpcomingAppointmentLoading) {
                return ComplexShimmer.cardShimmer(
                        itemCount: 1,
                        margin: EdgeInsets.symmetric(vertical: 20))
                    .withCustomPadding();
              } else if (state is UpcomingAppointmentError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomErrorScreen(
                      message: state.message,
                      onTap: () {
                        context
                            .read<UpcomingAppointmentCubit>()
                            .fetchUpcomingAppointments();
                      },
                    ),
                  ],
                );
              } else if (state is UpcomingAppointmentEmpty) {
                return Container();
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

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetUserChatRoomsCubit, GetUserChatRoomsState>(
        builder: (context, state) {
          if (state is GetUserChatRoomsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetUserChatRoomsCubit>().fetchUserChatRooms();
                Constants.delayed();
              },
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: state.chatRooms.length,
                    itemBuilder: (context, index) {
                      var chatRoom = state.chatRooms[index];
                      return ListTile(
                        onTap: () {
                          context.goNamed(
                            Routes.chatRoomName,
                            extra: chatRoom,
                            pathParameters: {
                              'id': chatRoom.chatRoomID.toString()
                            },
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: context.colors.greyDecor,
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
                        trailing: Assets
                            .application.assets.svgs.therapistMessage
                            .svg(),
                        title: Text(chatRoom.senderName),
                        subtitle: Text(
                          "Tap to open chat",
                          style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 8, fontWeight: FontWeight.w700),
                        ),
                      );
                    },
                  ).withExpanded(),
                ],
              ).withCustomPadding(),
            );
          } else if (state is GetUserChatRoomsLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ComplexShimmer.listShimmer(itemCount: 7)
                //     .withExpanded()
                //     .withCustomPadding(),
                CircularProgressIndicator().toCenter()
              ],
            );
          } else if (state is GetUserChatRoomsError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomErrorScreen(
                  onTap: () {},
                  message: state.failure.message,
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Welcome to the Patient feature!'),
            );
          }
        },
      ),
    );
  }
}
