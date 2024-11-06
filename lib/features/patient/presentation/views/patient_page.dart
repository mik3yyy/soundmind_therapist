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
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/core/widgets/custom_shimmer.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/core/widgets/error_screen.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_chat_room.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room/get_user_chat_rooms_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/chat/chat_room.dart';
import '../blocs/patient_bloc.dart';

class PatientPage extends StatefulWidget {
  PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<GetUserChatRoomsCubit>().state;

    if (state is! GetUserChatRoomsSuccess) {
      context.read<GetUserChatRoomsCubit>().fetchChatRooms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Patient'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: CustomTextField(
            controller: controller,
            radius: 30,
            prefix: const Icon(Icons.search),
            hintText: "Search",
          ).withCustomPadding(),
        ),
      ),
      body: BlocBuilder<GetUserChatRoomsCubit, GetUserChatRoomsState>(
        builder: (context, state) {
          if (state is GetUserChatRoomsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetUserChatRoomsCubit>().fetchChatRooms();
                Constants.delayed();
              },
              child: Column(
                children: [
                  Gap(10),
                  ListView.builder(
                    itemCount: state.chatRooms.length,
                    itemBuilder: (context, index) {
                      var chatRoom = state.chatRooms[index];
                      return ListTile(
                        onTap: () {
                          context.goNamed(
                            Routes.view_patientName,
                            pathParameters: {
                              'id': chatRoom.receiverID.toString()
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
                        subtitle: Text(
                          "Tap to open patient",
                          style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 8, fontWeight: FontWeight.w700),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              print(chatRoom.receiverID);
                              print(chatRoom.chatRoomID);
                              context.goNamed(
                                Routes.chatRoomName,
                                extra: chatRoom,
                                pathParameters: {
                                  'id': chatRoom.chatRoomID.toString()
                                },
                              );
                            },
                            icon: Assets
                                .application.assets.svgs.therapistMessage
                                .svg()),
                        title: Text(chatRoom.senderName),
                      );
                    },
                  ).withExpanded(),
                ],
              ).withCustomPadding(),
            );
          } else if (state is GetUserChatRoomsLoading) {
            return ComplexShimmer.listShimmer(itemCount: 7)
                .withExpanded()
                .withCustomPadding();
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
    );
  }
}
