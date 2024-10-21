import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/list_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.application.assets.images.logoPurple.image(
            height: 120,
            width: 120,
          ),
          AutoSizeText(
            "Register as a Therapist",
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          AutoSizeText(
            "Your information will be collected and verified. If you meet the criteria required, your submission will be approved and your authentication details will be sent to your email ",
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
        ].addSpacer(const Gap(20)),
      ).withCustomPadding(),
      bottomSheet: SizedBox(
        height: 100,
        width: context.screenWidth,
        child: Column(children: [
          CustomButton(
            label: "Get Started",
            onPressed: () {
              context.pushNamed(Routes.personal_infoName);
            },
          )
              .animate()
              .slideY(
                delay: const Duration(milliseconds: 200),
                begin: 1.0,
                end: 0.0,
                duration: const Duration(milliseconds: 500),
              )
              .fadeIn(),
        ]),
      ),
    );
  }
}
