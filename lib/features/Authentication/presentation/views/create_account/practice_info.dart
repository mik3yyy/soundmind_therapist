import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/practical_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class PracticeInfoScreen extends StatefulWidget {
  const PracticeInfoScreen({super.key});

  @override
  State<PracticeInfoScreen> createState() => _PracticeInfoScreenState();
}

class _PracticeInfoScreenState extends State<PracticeInfoScreen> {
  final signupForm = GlobalKey<FormState>();
  TextEditingController _practiceName = TextEditingController();
  TextEditingController _rate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Practice Information",
                style: context.textTheme.displayMedium,
              ),
              Text(
                "Your personal information is required to help get define a base to your profile information",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          CustomTextField(
            controller: _practiceName,
            hintText: "Enter your  address",
            titleText: "Practice Address",
          ),
          CustomTextField(
            controller: _rate,
            titleText: "Rate/hr",
            hintText: "e.g \$60",
            keyboardType: TextInputType.number,
          ),
        ].addSpacer(const Gap(10)),
      )
          .withSafeArea()
          .withCustomPadding()
          .withForm(signupForm)
          .withScrollView(),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: CustomButton(
          label: "Next",
          onPressed: () {
            var state = context.read<AuthenticationBloc>().state
                as ProfessionalInfoState;
            context.read<AuthenticationBloc>().add(
                  PracticalInfoEvent(
                    personalInfoModel: state.personalInfoModel,
                    professionalInfoModel: state.professionalInfoModel,
                    practicalInfoModel: PracticalInfoModel(
                      practiceAddress: _practiceName.text,
                      schedules: [],
                      consultationRate: int.parse(_rate.text),
                    ),
                  ),
                );
          },
        ).toCenter(),
      ),
    );
  }
}
