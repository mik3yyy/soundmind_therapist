import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/features/main/presentation/views/main_page.dart';
import 'package:soundmind_therapist/features/patient/presentation/views/referaals/referrals.dart';

class SignupSuccesfulScreen extends StatefulWidget {
  const SignupSuccesfulScreen({super.key});

  @override
  State<SignupSuccesfulScreen> createState() => _SignupSuccesfulScreenState();
}

class _SignupSuccesfulScreenState extends State<SignupSuccesfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.application.assets.svgs.fi16973516.svg(),
          Gap(10),
          Text(
            "Profile information\nsubmitted successful",
            textAlign: TextAlign.center,
            style: context.textTheme.displayLarge,
          ),
          Gap(2),
          const Text(
            "Your profile information has been successfully sent and awaiting approval, upon approval a mail will be sent with your login credentials.",
            textAlign: TextAlign.center,
          ),
        ],
      ).withCustomPadding(),
      bottomNavigationBar: Container(
        height: 150,
        child: Center(
          child: CustomButton(
            label: "Proceed",
            onPressed: () {
              context.replaceNamed(Routes.loginName);
            },
          ),
        ),
      ),
    );
  }
}
