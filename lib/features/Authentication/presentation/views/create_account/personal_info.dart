import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/utils/constants.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_date_picker.dart';
import 'package:soundmind_therapist/core/widgets/custom_dropdown_widget.dart';
import 'package:soundmind_therapist/core/widgets/custom_phone_number_field.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/personal_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/check_if_phone_and_email_exist.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/check_user_data/check_if_phone_and_email_exist_cubit.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> with Validators, AutomaticKeepAliveClientMixin {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _cpasswordController = TextEditingController();
  String? gender;
  final TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber = '';
  final signupForm = GlobalKey<FormState>();
  String? dob;
  @override
  bool get wantKeepAlive => true; // Preserve state

  @override
  Widget build(BuildContext context) {
    super.build(context); // Important!

    return BlocListener<CheckIfPhoneAndEmailExistCubit, CheckIfPhoneAndEmailExistState>(
      listener: (context, state) {
        if (state is CheckIfPhoneAndEmailExistFailure) {
          context.showSnackBar(state.error);
        }
        if (state is CheckIfPhoneAndEmailExistSuccess) {
          context.read<AuthenticationBloc>().add(
                PersonalInfoEvent(
                  page: 1,
                  personalInfoModel: PersonalInfoModel(
                    firstname: _firstName.text,
                    lastname: _lastName.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    passwordConfirmation: _passwordController.text,
                    dob: dob!,
                    gender: Constants.convertGender(gender!),
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: context.textTheme.displayMedium,
                ),
                Text(
                  "Your personal information is required to help get define a base to your profile information.",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            CustomTextField(
              controller: _firstName,
              hintText: "Enter your first name",
              titleText: 'First Name',
              validator: validateField,
            ),
            CustomTextField(
              controller: _lastName,
              hintText: "Enter your last name",
              titleText: 'Last Name',
              validator: validateField,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: "Enter your email",
              titleText: 'Email',
              validator: validateEmail,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: "password",
              titleText: 'Password',
              validator: validatePassword,
              isPasswordField: true,
            ),
            CustomTextField(
              controller: _cpasswordController,
              isPasswordField: true,
              validator: (value) => validateConfirmPassword(passowrd: _passwordController.text, confirmPassword: value),
              titleText: "Confirm Password",
              hintText: "",
            ),
            CustomDatePicker(
              title: "Date of birth",
              onDateChanged: (DateTime dateTime) {
                setState(() {
                  dob = DateFormater.formatDate(dateTime);
                });
              },
            ),
            CustomDropdown(
              title: "Gender",
              items: Constants.genders,
              itemToString: (String item) => item,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            CustomPhoneNumber(
              phoneNumberController: _phoneNumberController,
              phoneNumberValue: (String fullNumber) {
                phoneNumber = fullNumber;
              },
            ),
            const Gap(2),
            BlocBuilder<CheckIfPhoneAndEmailExistCubit, CheckIfPhoneAndEmailExistState>(
              builder: (context, state) {
                return CustomButton(
                  notifier: ValueNotifier(state is CheckIfPhoneAndEmailExistLoading || state is CreatingAccount),
                  label: "Next",
                  onPressed: () {
                    if (!signupForm.currentState!.validate()) {
                      return;
                    }
                    if (dob == null || gender == null) {
                      context.showSnackBar("Fill all fields");
                      return;
                    }
                    context
                        .read<CheckIfPhoneAndEmailExistCubit>()
                        .checkIfPhoneAndEmailExist(_emailController.text, phoneNumber);
                  },
                );
              },
            )
          ].addSpacer(const Gap(10)),
        ).withSafeArea().withForm(signupForm).withPadding(const EdgeInsets.symmetric(horizontal: 20)).withScrollView(),
      ),
    );
  }
}
