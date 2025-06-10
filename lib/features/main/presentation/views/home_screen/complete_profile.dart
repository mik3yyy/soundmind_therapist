import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/routes/routes.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/profile_data.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/blocs/therapist_profile/therapist_profile_cubit.dart';

class ProfileCompletionCard extends StatefulWidget {
  const ProfileCompletionCard({Key? key, required this.profileData}) : super(key: key);
  final ProfileData profileData;

  @override
  State<ProfileCompletionCard> createState() => _ProfileCompletionCardState();
}

class _ProfileCompletionCardState extends State<ProfileCompletionCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapistProfileCubit, TherapistProfileState>(
      listener: (context, state) {
        setState(() {});
      },
      builder: (context, state) {
        int count = context.read<TherapistProfileCubit>().falseFields ?? 0;

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE1F5F3), Color(0xFFFFF0F0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'You are ${count} steps away from meeting your first patient✨',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6E50C1),
                        ),
                      ),
                    ),
                    _buildProgressIndicator(count),
                  ],
                ),
                if (!widget.profileData.professionalInformationCompleted) ...[
                  const SizedBox(height: 5),
                  _buildStepCard(
                    title: 'Provide your professional details',
                    description:
                        'License Issuing authority, Area of specialization,\nYears of experience, Professional affiliations etc.',
                    buttonText: 'Continue',
                    onTap: () {
                      context.pushNamed(Routes.professioanlInfoName);
                    },
                  ),
                ],
                if (!widget.profileData.practiceInformationCompleted) ...[
                  const SizedBox(height: 5),
                  _buildStepCard(
                      title: 'Provide your practice information',
                      description:
                          'License Issuing authority, Area of specialization,\nYears of experience, Professional affiliations etc.',
                      buttonText: 'Get started',
                      onTap: () {
                        context.pushNamed(Routes.practiceInfoName);
                      }),
                ],
                if (!widget.profileData.verificationDocumentCompleted) ...[
                  const SizedBox(height: 5),
                  _buildStepCard(
                    title: 'Submit verification documents',
                    description: 'Professional License upload, Degree\nCertificates, Years of experience.',
                    buttonText: 'Upload docs',
                    onTap: () {
                      context.pushNamed(Routes.verificationInfoName);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildProgressIndicator(int count) {
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          value: (4 - count) / 4, // 1/4 progress
          strokeWidth: 3,
          backgroundColor: Colors.grey.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6E50C1)),
        ),
      ),
      Text(
        '${4 - count}/4',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6E50C1),
        ),
      ),
    ],
  );
}

Widget _buildStepCard(
    {required String title, required String description, required String buttonText, required VoidCallback onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  maxFontSize: 12,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                AutoSizeText(
                  description,
                  maxFontSize: 10,
                  minFontSize: 3,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2EBFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6E50C1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
