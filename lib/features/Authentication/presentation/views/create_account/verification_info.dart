import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_upload_file.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/upload.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/verification_model.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/therapist_profile/therapist_profile_cubit.dart';
import 'package:soundmind_therapist/features/wallet/presentation/widgets/succesful.dart';

class VerificationInfoScreen extends StatefulWidget {
  const VerificationInfoScreen({super.key});

  @override
  State<VerificationInfoScreen> createState() => _VerificationInfoScreenState();
}

class _VerificationInfoScreenState extends State<VerificationInfoScreen> with AutomaticKeepAliveClientMixin {
  final signupForm = GlobalKey<FormState>();
  File? professionalUpload;
  int proInt = 0;
  File? govIDUpload;
  int govInt = 0;

  File? Degree;
  int proDre = 0;
  File? profilePicture;
  int profInt = 0;
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
                "Verification documents",
                style: context.textTheme.displayMedium,
              ),
              Text(
                "Your personal information is required to help get define a base to your profile information ",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          const Gap(10),
          Uploadfile(
            title: 'Professional License upload',
            onTap: (File? file, int type) {
              setState(() {
                professionalUpload = file;
                proInt = type;
              });
            },
          ),
          const Gap(10),
          Uploadfile(
            title: 'Government ID upload',
            onTap: (File? file, int type) {
              setState(() {
                govIDUpload = file;
                govInt = type;
              });
            },
          ),
          const Gap(10),
          Uploadfile(
            title: 'Degree Certification',
            onTap: (File? file, int type) {
              setState(() {
                Degree = file;
                proDre = type;
              });
            },
          ),
          const Gap(10),
          Uploadfile(
            title: 'Professional License upload',
            onTap: (File? file, int type) {
              setState(() {
                profilePicture = file;
                profInt = type;
              });
            },
          ),
        ],
      ).withSafeArea().withCustomPadding().withForm(signupForm).withScrollView(),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Row(
          children: [
            BlocConsumer<TherapistProfileCubit, TherapistProfileState>(
              listener: (context, state) {
                if (state is TherapistProfileSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // User must tap button to close dialog
                    builder: (BuildContext context) {
                      return SuccessfulWidget(
                        message: "Your verification info has been successfully updated!",
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
                  label: 'Next',
                  notifier: ValueNotifier(state is TherapistProfileLoading),
                  enable: professionalUpload != null && govIDUpload != null && Degree != null,
                  onPressed: () {
                    context.read<TherapistProfileCubit>().uploadVerificarionInfo(
                          VerificationInfoModel(
                            license: Upload(path: professionalUpload!.path, type: proInt, purpose: 1),
                            govID: Upload(path: govIDUpload!.path, type: govInt, purpose: 2),
                            degree: Upload(path: Degree!.path, type: proDre, purpose: 4),
                            profile: Upload(path: profilePicture!.path, type: profInt, purpose: 3),
                          ),
                        );
                  },
                );
              },
            ).withExpanded()
          ],
        ).withCustomPadding(),
      ),
    );
  }
}
