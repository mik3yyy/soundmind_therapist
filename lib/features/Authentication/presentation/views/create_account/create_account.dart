import 'package:flutter/material.dart';
import 'package:flutter_animated_progress_bar/flutter_animated_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/personal_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/practice_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/professional_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/profile_info.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/verification_info.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  // final Widget child;
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> with TickerProviderStateMixin {
  late final ProgressBarController _controller;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    _controller = ProgressBarController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int time = 10;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is ProfileInfoState) {
          var page = state.page ?? 0;
          // pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          if (state.message != null) {
            context.showSnackBar(state.message!);
          }
          setState(() {
            time = page * 20;
          });
        }
        if (state is VerifyAccount) {
          context.goNamed(Routes.verifyName, extra: state.personalInfoModel?.email);
        }
        // if (state is PersonalInfoState) {
        //   context.goNamed(Routes.professioanlInfoName);
        //   time = 20;
        // }
        // if (state is ProfessionalInfoState) {
        //   context.goNamed(Routes.practiceInfoName);
        //   time = 30;
        // }
        // if (state is PracticalInfoState) {
        //   context.goNamed(Routes.verificationInfoName);
        //   time = 45;
        // }
        // if (state is VerificationInfoState) {
        //   if (state.message != null) {
        // context.showSnackBar(state.message!);
        // return;
        //   }
        //   context.goNamed(Routes.profileInfoName);
        // }
        // if (state is ProfileInfoState) {
        //   time = 60;
        // }
        // setState(() {});
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Assets.application.assets.images.logoPurple
                .image(
                  height: 40,
                  width: 40,
                )
                .withPadding(const EdgeInsetsDirectional.symmetric(horizontal: 8)),
            // bottom: PreferredSize(
            //   preferredSize: const Size.fromHeight(20),
            //   child: ProgressBar(
            //     controller: _controller,
            //     expandedProgressBarColor: context.primaryColor,
            //     collapsedBufferedBarColor: context.primaryColor,
            //     collapsedProgressBarColor: context.primaryColor,
            //     progress: Duration(seconds: time),
            //     buffered: Duration(seconds: time),
            //     total: const Duration(minutes: 1),
            //     onSeek: (position) {},
            //   ).withClip(1000).withPadding(
            //       const EdgeInsetsDirectional.symmetric(horizontal: 8)),
            // ),
          ),
          body: PageView(
            controller: pageController,
            children: const [
              PersonalInfoScreen(),
              // PracticeInfoScreen(),
              // ProfessionalInfoScreen(),
              // VerificationInfoScreen(),
              // ProfileInfoScreen(),
            ],
          ),
        );
      },
    );
  }
}
