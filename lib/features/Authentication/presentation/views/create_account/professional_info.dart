import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_date_picker.dart';
import 'package:soundmind_therapist/core/widgets/custom_dropdown_widget.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class ProfessionalInfoScreen extends StatefulWidget {
  const ProfessionalInfoScreen({super.key});

  @override
  State<ProfessionalInfoScreen> createState() => _ProfessionalInfoScreenState();
}

class _ProfessionalInfoScreenState extends State<ProfessionalInfoScreen>
    with Validators {
  TextEditingController _lincenseNumber = TextEditingController();

  TextEditingController _issueAuthority = TextEditingController();

  TextEditingController _Yoe = TextEditingController();

  TextEditingController _proAffilations = TextEditingController();
  final signupForm = GlobalKey<FormState>();
  String? aoe;
  List<String> aoes = ['a', 'b', 'c'];
  String? licenseExpiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Professional Information",
                style: context.textTheme.displayMedium,
              ),
              Text(
                "Kindly provide your professional informations accurately as they will determine if your application is approved or not.",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          CustomTextField(
            controller: _lincenseNumber,
            hintText: "Enter lincense number",
            titleText: "Lincense number",
            validator: validateField,
          ),
          CustomTextField(
            controller: _issueAuthority,
            hintText: "Enter license Issuing authority",
            titleText: "License Issuing authority",
            validator: validateField,
          ),
          CustomDatePicker(
            onDateChanged: (DateTime dateTime) {
              setState(() {
                licenseExpiryDate = DateFormater.formatDate(dateTime);
              });
            },
            title: "License expiry date",
            mode: DatePMode.license,
          ),
          CustomDropdown(
            items: aoes,
            title: "Area of specialization",
            itemToString: (item) => item,
            onChanged: (item) {
              aoe = item;
            },
          ),
          CustomTextField(
            controller: _Yoe,
            hintText: "E.g 12",
            titleText: "Years of experience",
            validator: validateNumber,
          ),
          CustomTextField(
            controller: _proAffilations,
            hintText: "e.g ACA, AAC",
            keyboardType: TextInputType.number,
            titleText: "Professional affliations",
            validator: validateField,
          ),
        ].addSpacer(const Gap(10)),
      )
          .withSafeArea()
          .withCustomPadding()
          .withForm(signupForm)
          .withScrollView(),
      bottomNavigationBar: Container(
        height: 150,
        child: CustomButton(
          label: "Continue",
          onPressed: () {
            if (!signupForm.currentState!.validate()) {
              return;
            }
            if (licenseExpiryDate == null || aoe == null) {
              context.showSnackBar("Fill al fields");
            }
            var state =
                context.read<AuthenticationBloc>().state as PersonalInfoState;
            context.read<AuthenticationBloc>().add(ProfessionalInfoEvent(
                personalInfoModel: state.personalInfoModel,
                professionalInfoModel: ProfessionalInfoModel(
                    licenseNum: _lincenseNumber.text,
                    issuingAuthority: _issueAuthority.text,
                    qualifications: [],
                    yoe: int.parse(_Yoe.text),
                    professionalAffiliation: _proAffilations.text,
                    aos: aoe!,
                    licenseExpiryDate: licenseExpiryDate!)));
          },
        ),
      ),
    );
  }
}
