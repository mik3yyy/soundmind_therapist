import 'package:flutter/material.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/utils/validators.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/cubit/resend_otp_cubit.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.email});
  final String email;
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> with Validators {
  final TextEditingController _otpController = TextEditingController();
  final verifyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResendOtpCubit, ResendOtpState>(
      listener: (context, state) {
        if (state is ResendOtpSuccess) {
          context.showSnackBar("Resent Successfully");
        }
        if (state is ResendOtpFailure) {
          context.showSnackBar(state.message);
        }
        // TODO: implement listener
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UserAccount) {
            context.goNamed(Routes.homeName);
          }
          if (state is VeriftingAccountFailed) {
            context.showSnackBar(state.message);
          }
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.application.assets.svgs.email.svg(),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Code sent to email",
                        style: context.textTheme.displayLarge,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "A code has been sent to the email ",
                          style: context.textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: ' ${widget.email} ',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text:
                                  'enter the code provided in the email to complete the sign up process',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              CustomTextField(
                controller: _otpController,
                hintText: "e.g 00000",
                keyboardType: TextInputType.number,
                validator: validateDigit,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return RichText(
                  text: TextSpan(
                    text: "Didn’t get an email? ",
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Resend email',
                        style: context.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          color: context.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (state is VeriftingAccountFailed) {
                              context
                                  .read<ResendOtpCubit>()
                                  .resendOtp(state.verificationData['data']);
                            } else if (state is VerifyAccount) {
                              context
                                  .read<ResendOtpCubit>()
                                  .resendOtp(state.verificationData['data']);
                            }
                          },
                      ),
                    ],
                  ),
                );
              }).toCenter()
            ].addSpacer(const Gap(20)),
          ).withSafeArea().withCustomPadding().withForm(verifyForm),
          bottomNavigationBar: Container(
            height: 200,
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is VerifyingAccount) {
                  // var currentState = state;

                  return CustomButton(
                    label: "Proceed",
                    notifier: ValueNotifier(true),
                    onPressed: () {
                      // if (!verifyForm.currentState!.validate()) return;
                      // context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                      //     otp: _otpController.text,
                      //     verificationData: state.verificationData));
                    },
                  );
                } else if (state is VeriftingAccountFailed) {
                  return CustomButton(
                    label: "Proceed",
                    onPressed: () {
                      if (!verifyForm.currentState!.validate()) return;
                      context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                          otp: _otpController.text,
                          verificationData: state.verificationData));
                    },
                  );
                } else if (state is VerifyAccount) {
                  return CustomButton(
                    label: "Proceed",
                    onPressed: () {
                      if (!verifyForm.currentState!.validate()) return;
                      context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                          otp: _otpController.text,
                          verificationData: state.verificationData));
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
