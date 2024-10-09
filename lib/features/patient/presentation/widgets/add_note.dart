import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/add_user_note.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/add_user_note/add_user_note_cubit.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.id});
  final String id;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        title: Text("New Note"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: controller,
            hintText: "Write notes here",
            maxLines: 20,
            onChanged: (vlai) {
              setState(() {});
            },
          )
        ],
      ).withCustomPadding(),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: BlocConsumer<AddUserNoteCubit, AddUserNoteState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AddUserNoteSuccess) {
              context.pop();
              context
                  .read<GetPatientDetailsCubit>()
                  .fetchPatientDetails(int.parse(widget.id));
            }
          },
          builder: (context, state) {
            return CustomButton(
              enable: controller.text.isNotEmpty,
              notifier: ValueNotifier(state is AddUserNoteLoading),
              label: "Save note",
              onPressed: () {
                context.read<AddUserNoteCubit>().addNote(
                    patientId: int.parse(widget.id), note: controller.text);
              },
            );
          },
        ).withCustomPadding(),
      ),
    );
  }
}
