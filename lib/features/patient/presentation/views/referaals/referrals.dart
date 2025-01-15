import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';

import 'package:soundmind_therapist/core/utils/constants.dart';
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/core/widgets/custom_shimmer.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_field.dart';
import 'package:soundmind_therapist/core/widgets/empty_screen.dart';
import 'package:soundmind_therapist/core/widgets/error_screen.dart';
import 'package:soundmind_therapist/features/patient/data/models/referral.dart';

import 'package:soundmind_therapist/features/patient/presentation/blocs/get_referrals/get_referrals_cubit.dart';

class ReferallPage extends StatefulWidget {
  const ReferallPage({super.key});

  @override
  State<ReferallPage> createState() => _ReferallPageState();
}

class _ReferallPageState extends State<ReferallPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    var state = context.read<GetReferralsCubit>().state;

    if (state is! GetReferralsSuccess) {
      context.read<GetReferralsCubit>().fetchReferrals();
    } else {
      rooms = state.referrals;
      filteredR = state.referrals;
    }
  }

  List<Referral> rooms = [];

  List<Referral> filteredR = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Referrals'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: CustomTextField(
            controller: controller,
            radius: 30,
            prefix: const Icon(Icons.search),
            hintText: "Search",
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  filteredR = rooms;
                });
              } else {
                filteredR = rooms
                    .where((e) => (e.fname + e.lname)
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                setState(() {});
              }
            },
          ).withCustomPadding(),
        ),
      ),
      body: BlocConsumer<GetReferralsCubit, GetReferralsState>(
        listener: (context, state) {
          if (state is GetReferralsSuccess) {
            rooms = state.referrals;
            filteredR = state.referrals;
          }
        },
        builder: (context, state) {
          if (state is GetReferralsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetReferralsCubit>().fetchReferrals();
                Constants.delayed();
              },
              child: Column(
                children: [
                  const Gap(10),
                  ListView.builder(
                    itemCount: filteredR.length,
                    itemBuilder: (context, index) {
                      var chatRoom = filteredR[index];
                      return ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: context.colors.greyDecor,
                          child: CachedNetworkImage(
                            imageUrl: ImageUtils.profile,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                CachedNetworkImage(
                                    imageUrl: ImageUtils.profile),
                          ),
                        ).withClip(20),
                        title: Text("${chatRoom.lname} ${chatRoom.fname} "),
                        subtitle: Text('${chatRoom.institutionName}'),
                      );
                    },
                  ).withExpanded(),
                ],
              ).withCustomPadding(),
            );
          } else if (state is GetReferralsLoading) {
            return Container(
              width: context.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          } else if (state is GetReferralsEmpty) {
            return CustomEmptyScreen(
              onTap: () {},
            );
          } else if (state is GetReferralsError) {
            return CustomErrorScreen(
              onTap: () {},
              message: state.message,
            );
          } else {
            return const Center(
              child: Text('Welcome to the Patient feature!'),
            );
          }
        },
      ),
    );
  }
}
