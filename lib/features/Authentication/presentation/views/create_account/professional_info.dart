import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_date_picker.dart';
import 'package:soundmind_therapist/core/widgets/custom_dropdown_widget.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/professional_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit_gas/get_gas_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/therapist_profile/therapist_profile_cubit.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/widgets/education_pop_up.dart';
import 'package:soundmind_therapist/features/wallet/presentation/widgets/succesful.dart';

class ProfessionalInfoScreen extends StatefulWidget {
  const ProfessionalInfoScreen({super.key});

  @override
  State<ProfessionalInfoScreen> createState() => _ProfessionalInfoScreenState();
}

class _ProfessionalInfoScreenState extends State<ProfessionalInfoScreen>
    with Validators, AutomaticKeepAliveClientMixin {
  TextEditingController _lincenseNumber = TextEditingController();

  TextEditingController _issueAuthority = TextEditingController();

  TextEditingController _Yoe = TextEditingController();

  TextEditingController _proAffilations = TextEditingController();
  TextEditingController _controller = TextEditingController();

  TextEditingController _practiceName = TextEditingController();
  TextEditingController _rate = TextEditingController();
  final signupForm = GlobalKey<FormState>();
  String? aoe;
  // List<String> aoes = ['a', 'b', 'c'];
  String? licenseExpiryDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<GetGasCubit>().state;
    if (state is! GetgasSuccess) {
      context.read<GetGasCubit>().getGas();
    }
  }

  @override
  bool get wantKeepAlive => true; // Preserve state
  @override
  Widget build(BuildContext context) {
    super.build(context); // Important!

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            context.pop();
          },
        ),
      ),
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
          BlocBuilder<GetGasCubit, GetGasState>(
            builder: (context, state) {
              if (state is GetgasSuccess) {
                return CustomDropdown(
                  items: state.gas,
                  title: "Area of specialization",
                  itemToString: (item) => item.name,
                  onChanged: (item) {
                    if (item != null) {
                      aoe = item.id.toString();
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          CustomTextField(
            controller: _Yoe,
            hintText: "E.g 12",
            titleText: "Years of experience",
            keyboardType: TextInputType.number,
            validator: validateNumber,
          ),
          CustomTextField(
            controller: _proAffilations,
            hintText: "e.g ACA, AAC",
            keyboardType: TextInputType.name,
            titleText: "Professional affliations",
            validator: validateField,
          ),
          const Gap(10),
          CustomTextField(
            controller: _controller,
            titleText: "Bio",
            hintText: "Enter a bio about yourself",
            // textInputAction: TextInputAction.newline,
            maxLines: 10,
            onChanged: (value) {
              setState(() {});
            },
          ),
          CustomTextField(
            controller: _rate,
            titleText: "Rate/hr",
            hintText: "e.g \$60",
            validator: validateNumber,
            keyboardType: TextInputType.number,
            onChanged: (valur) {
              setState(() {});
            },
          ),
          CustomTextField(
            controller: _practiceName,
            hintText: "Enter your  address",
            titleText: "Practice Address",
            validator: validateField,
            onChanged: (valur) {
              setState(() {});
            },
          ),
        ].addSpacer(const Gap(10)),
      ).withSafeArea().withCustomPadding().withForm(signupForm).withScrollView(),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 100,
        child: Row(
          children: [
            Gap(5),
            BlocConsumer<TherapistProfileCubit, TherapistProfileState>(
              listener: (context, state) {
                if (state is TherapistProfileSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // User must tap button to close dialog
                    builder: (BuildContext context) {
                      return SuccessfulWidget(
                        message: "Your professional info has been successfully updated!",
                        onTap: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          context.pop();
                        },
                      );
                    },
                  );
                }
                if (state is TherapistProfileFailue) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  label: "Submit",
                  notifier: ValueNotifier(state is TherapistProfileLoading),
                  onPressed: () {
                    if (!signupForm.currentState!.validate()) {
                      return;
                    }
                    if (licenseExpiryDate == null || aoe == null && _controller.text.isNotEmpty) {
                      context.showSnackBar("Fill all fields");
                    }
                    context.read<TherapistProfileCubit>().uploadProfessionalInfo(
                          ProfessionalInfoModel(
                            licenseNum: _lincenseNumber.text,
                            issuingAuthority: _issueAuthority.text,
                            yoe: int.parse(_Yoe.text),
                            professionalAffiliation: _proAffilations.text,
                            aos: aoe!,
                            licenseExpiryDate: licenseExpiryDate!,
                            consultationRate: int.parse(_rate.text),
                            bio: _controller.text,
                            practiceAddress: _practiceName.text,
                          ),
                        );
                  },
                );
              },
            ).withExpanded(),
          ],
        ).withCustomPadding(),
      ),
    );
  }
}
