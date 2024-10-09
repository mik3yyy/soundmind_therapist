import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
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
    context.read<GetUserChatRoomsCubit>().fetchChatRooms();
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
            return Column(
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
                          icon: const Icon(Icons.chat)),
                      title: Text(chatRoom.senderName),
                      subtitle: Text(""),
                    );
                  },
                ).withExpanded(),
              ],
            ).withCustomPadding();
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
