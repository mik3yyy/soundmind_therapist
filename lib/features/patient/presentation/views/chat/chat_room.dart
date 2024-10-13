import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_user_chat_room_messages/get_user_chat_room_messages_cubit.dart';
import 'package:logging/logging.dart';

class ChattRoomScreen extends StatefulWidget {
  const ChattRoomScreen(
      {super.key, required this.chat_id, required this.user_id});

  final int chat_id;
  final ChatRoom user_id;
  @override
  State<ChattRoomScreen> createState() => _ChattRoomScreenState();
}

class _ChattRoomScreenState extends State<ChattRoomScreen> {
  late HubConnection _hubConnection;
  bool isConnected = false;
  final _logger = Logger("SignalR - chat");

  @override
  void initState() {
    super.initState();

    context
        .read<GetUserChatRoomMessagesCubit>()
        .fetchChatMessages(widget.chat_id);
    _setupSignalRConnection();
  }

  // Setup the SignalR connection
  Future<void> _setupSignalRConnection() async {
    final serverUrl =
        "https://soundmind-api.onrender.com/chathub?chatroomId=${widget.chat_id}";

    // Logger configuration for debugging
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    final httpOptions = HttpConnectionOptions(
      logger: _logger,
      accessTokenFactory: () async {
        final box = Hive.box('userBox'); // Replace 'authBox' with your box name

        // Retrieve the token from Hive using the 'token' key
        final token = box.get('userKey', defaultValue: '');

        if (token != null && token.isNotEmpty) {
          // Add the Bearer token to the Authorization header
          return '${token['token']}';
        } else {
          return '';
        }
      },
      transport: HttpTransportType.WebSockets, // WebSockets transport
    );

    _hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(_logger)
        .withAutomaticReconnect()
        .build();

    _hubConnection.on("ReceiveMessage", (List<Object?>? parameters) {
      if (parameters != null && parameters.isNotEmpty) {
        String message = parameters[2].toString();
        print(parameters);
        print("Message received: $message");

        messages.add(ChatMessage.fromMessage(
          message: message,
          chatId: widget.chat_id,
          senderId: parameters[0] as int,
          receiverId: widget.user_id.receiverID,
        ));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
        // messages.add(ChatMessage(senderId: parameters[1] as int, chatId: parameters[0] as int, message: message, id: id, timeCreated: timeCreated, timeUpdated: timeUpdated));
        // Handle the message as needed
      } else {
        print("No parameters received.");
      }
    }); // Handle connection close
    _hubConnection.onclose(({Exception? error}) {
      if (error != null) {
        print("Connection closed due to an error: $error");
      } else {
        print("Connection closed.");
      }
      setState(() {
        isConnected = false;
      });
    });

    await _startConnection();
  }

  // Start the SignalR connection
  Future<void> _startConnection() async {
    await _hubConnection.start()?.then((_) {
      print("Connected to SignalR");
      setState(() {
        isConnected = true;
      });
    }).catchError((error) {
      print("Failed to connect to SignalR: $error");
    });
  }

  // Send a message to the server
  Future<void> _sendMessage(String message) async {
    if (isConnected) {
      var user =
          (context.read<AuthenticationBloc>().state as UserAccount).userModel;
      try {
        setState(() {
          messages.add(ChatMessage.fromMessage(
            message: message,
            chatId: widget.chat_id,
            senderId: user.userId,
            receiverId: widget.user_id.receiverID,
          ));
          controller.text = '';
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
        await _hubConnection.invoke(
          "SendMessage",
          args: <Object>[widget.chat_id, message],
        );

        print(
            "Message sent: $message"); //flutter: [11, 4, Hello from client! dd]
      } catch (error) {
        setState(() {
          messages.removeLast();
          controller.text = message;
        });
        print("Error sending message: $error");
      }
    }
  }

  @override
  void dispose() {
    _hubConnection.stop();
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll to the bottom method
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  List<ChatMessage> messages = [];
  final ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user =
        (context.read<AuthenticationBloc>().state as UserAccount).userModel;

    return BlocListener<GetUserChatRoomMessagesCubit,
        GetUserChatRoomMessagesState>(
      listener: (context, state) {
        if (state is GetUserChatRoomMessagesSuccess) {
          setState(() {
            messages = state.messages;
          });

          // Ensure that scrolling happens after the UI frame is rendered
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
          centerTitle: false,
          title: Text(widget.user_id.senderName),
        ),
        body: Column(
          children: [
            ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const Gap(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                ChatMessage message = messages[index];
                if (message.senderId == user.userId) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(2),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          color: context.primaryColor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            message.message,
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          color: context.colors.greyDecor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(message.message),
                        ),
                      ),
                    ],
                  );
                }
              },
            ).withExpanded(),
            const Gap(100)
          ],
        ).withCustomPadding(),
        bottomSheet: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: context.screenWidth * .7,
                child: CustomTextField(
                  controller: controller,
                  hintText: "Enter a message",
                ),
              ),
              IconButton(
                  onPressed: () {
                    _sendMessage(controller.text);
                  },
                  icon: const Icon(Icons.send))
            ],
          ).withCustomPadding(),
        ),
      ),
    );
  }
}
