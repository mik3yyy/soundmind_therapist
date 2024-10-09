import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';

class ReferralWidget extends StatefulWidget {
  const ReferralWidget({super.key});

  @override
  State<ReferralWidget> createState() => _ReferralWidgetState();
}

class _ReferralWidgetState extends State<ReferralWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetPatientDetailsCubit, GetPatientDetailsState>(
        builder: (context, state) {
          if (state is GetPatientDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPatientDetailsSuccess) {
            var patient = state.patient;

            return ListView.builder(
              itemCount: patient.referrals.length,
              itemBuilder: (context, index) {
                String referral = patient.referrals[index];
                return ListTile(
                  title: Text(referral),
                );
              },
            );
          } else if (state is GetPatientDetailsError) {
            return Center(
              child: Text(
                'Failed to load patient details',
                style: context.textTheme.bodyLarge?.copyWith(
                    // color: context.colors.,
                    ),
              ),
            );
          } else {
            return const SizedBox
                .shrink(); // Return an empty widget for unknown states.
          }
        },
      ),
    );
  }
}
