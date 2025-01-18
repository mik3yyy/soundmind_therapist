import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/core/services/injection_container.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/core/widgets/custom_upload_file.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_info_model.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/upload.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen>
    with AutomaticKeepAliveClientMixin {
  File? profilePicture;
  int proInt = 0;
  TextEditingController _controller = TextEditingController();
  @override
  bool get wantKeepAlive => true; // Preserve state
  @override
  Widget build(BuildContext context) {
    super.build(context); // Important!

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Information",
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
                  profilePicture = file;
                  proInt = type;
                });
              },
            ),
            const Gap(10),
            CustomTextField(
              controller: _controller,
              titleText: "Bio",
              hintText: "Enter a bio about yourself",
              maxLines: 10,
              onChanged: (value) {
                setState(() {});
              },
            )
          ],
        ).withSafeArea().withCustomPadding().withScrollView(),
        bottomNavigationBar:
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return SizedBox(
              height: 150,
              child: CustomButton(
                label: "Next",
                notifier: ValueNotifier(state is CreatingAccount),
                enable: profilePicture != null && _controller.text.isNotEmpty,
                onPressed: () {
                  context.read<AuthenticationBloc>().add(
                        ProfileInfoEvent(
                          page: 5,
                          profileInfoEvent: ProfileInfoModel(
                              bio: _controller.text,
                              profilePicture: Upload(
                                  path: profilePicture!.path,
                                  type: proInt,
                                  purpose: 3)),
                        ),
                      );
                },
              ).toCenter(),
            );
          },
        ),
      ),
    );
  }
}
