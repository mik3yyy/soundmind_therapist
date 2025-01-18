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
import 'package:soundmind_therapist/features/Authentication/presentation/widgets/education_pop_up.dart';

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
  final signupForm = GlobalKey<FormState>();
  String? aoe;
  // List<String> aoes = ['a', 'b', 'c'];
  String? licenseExpiryDate;
  List<Qualification> qualifications = [];
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
          AutoSizeText(
            "Educational qualifications/Certification ",
            style: context.textTheme.titleLarge,
          ).toRight(),
          Column(
            children: qualifications
                .map<Widget>((qualification) {
                  return Container(
                    // height: 50,
                    width: context.screenWidth * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF1F1F1),
                    ),
                    child: ListTile(
                      title: Text(
                        qualification.schoolName,
                        style: context.textTheme.titleLarge,
                      ),
                      subtitle: Text(qualification.degree),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            qualifications.remove(qualification);
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: context.colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .addSpacer(Gap(10)),
          ),
          CustomTextButton(
            label: "Add New",
            textStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.primaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EducationPopUp(
                  onSubmit: (qualification) {
                    setState(() {
                      qualifications.add(qualification);
                    });
                    context.pop();
                  },
                ),
              );
            },
          ).toRight(),
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
            context.read<AuthenticationBloc>().add(ProfessionalInfoEvent(
                page: 3,
                professionalInfoModel: ProfessionalInfoModel(
                    licenseNum: _lincenseNumber.text,
                    issuingAuthority: _issueAuthority.text,
                    qualifications: qualifications,
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
