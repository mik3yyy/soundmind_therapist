import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/features/appointment/presentation/widgets/loding.dart';
import 'package:soundmind_therapist/features/patient/data/models/not.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/request_for_patient_notes/request_for_patient_notes_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/widgets/add_note.dart';
import 'package:soundmind_therapist/features/wallet/presentation/widgets/succesful.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key, required this.id});
  final String id;
  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  late bool access;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<GetPatientDetailsCubit>().state
        as GetPatientDetailsSuccess;
    access = state.patient.hasNotesAccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (access) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNote(
                          id: widget.id,
                        )));
          } else {
            context
                .showSnackBar("You do not have access to this patient notes");
          }
        },
        backgroundColor: context.primaryColor,
        child: Icon(
          Icons.add,
          color: context.colors.white,
        ),
      ),
      body: BlocListener<RequestForPatientNotesCubit,
          RequestForPatientNotesState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is RequestForPatientNotesLoading) {
            showDialog(
                useSafeArea: false,
                context: context,
                builder: (context) => const LoadingScreen());
          }
          if (state is RequestForPatientNotesSuccess) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => SuccessfulWidget(
                onTap: () {
                  context.pop();
                },
                message: "Notes Requested Successfully",
              ),
            );
          }
          if (state is RequestForPatientNotesError) {
            context.pop();
          }
        },
        child: BlocBuilder<GetPatientDetailsCubit, GetPatientDetailsState>(
          builder: (context, state) {
            var patient = (state as GetPatientDetailsSuccess).patient;
            if (!patient.hasNotesAccess) {
              return Column(
                children: [
                  Gap(30),
                  Text(
                    "Patient note by other doctors have been hidden to protect patient information, kindly request for the patient note to gain access",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(fontSize: 17),
                  ),
                  Gap(20),
                  CustomButton(
                    label: "Request for notes",
                    onPressed: () {
                      context
                          .read<RequestForPatientNotesCubit>()
                          .requestNotes(int.parse(widget.id));
                    },
                  )
                ],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: patient.notes.length,
              itemBuilder: (context, index) {
                Note note = patient.notes[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteViewer(note: note)));
                  },
                  trailing: CircleAvatar(
                      radius: 20,
                      backgroundColor: context.colors.purpleDecor,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: context.primaryColor,
                      )),
                  title: Text(note.doctorName),
                  subtitle: Text(
                    note.message.length > 30
                        ? note.message.substring(0, 20)
                        : note.message,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NoteViewer extends StatefulWidget {
  const NoteViewer({super.key, required this.note});
  final Note note;
  @override
  State<NoteViewer> createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        title: const Text("Note"),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.note.doctorName,
            style: context.textTheme.displayMedium,
          ),
          Text(
            widget.note.message,
            style: context.textTheme.bodyMedium,
          )
        ],
      ).withCustomPadding(),
    );
  }
}
