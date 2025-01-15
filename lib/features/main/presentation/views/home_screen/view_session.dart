import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/utils/date_formater.dart';
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/core/widgets/custom_button.dart';
import 'package:soundmind_therapist/core/widgets/custom_text_button.dart';
import 'package:soundmind_therapist/features/appointment/data/models/appointment_model.dart';
import 'package:soundmind_therapist/features/appointment/presentation/bloc/finalize_booking/finalize_booking_cubit.dart';
import 'package:soundmind_therapist/features/appointment/presentation/widgets/loding.dart';

class ViewSessionScreen extends StatefulWidget {
  const ViewSessionScreen({super.key, required this.appointment});
  final AppointmentModel appointment;
  @override
  State<ViewSessionScreen> createState() => _ViewSessionScreenState();
}

class _ViewSessionScreenState extends State<ViewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.secondaryColor, context.colors.white],
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
          ),
        ),
        child: BlocConsumer<FinalizeBookingCubit, FinalizeBookingState>(
          listener: (context, state) {
            if (state is FinalizeBookingLoading) {
              showDialog(
                  context: context,
                  builder: (context) => const LoadingScreen());
            }
            if (state is FinalizeBookingSuccess) {
              context.pop();
            }
            if (state is FinalizeBookingError) {
              context.pop();
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    leading: BackButton(
                      color: context.colors.black,
                    ),
                    title: const Text("Session"),
                    centerTitle: false,
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.appointment.profilePicture ??
                            ImageUtils.profile,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Text(widget.appointment.patientName),
                  // Text("${widget.appointment.areaOfSpecialization}"),
                  const Gap(20),
                  Container(
                    width: context.screenWidth * .9,
                    height: 72,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: context.secondaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.colors.white,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Time"),
                        Text(
                          DateFormater.formatTimeRange(
                              widget.appointment.schedule.startTime,
                              widget.appointment.schedule.endTime),
                          style: context.textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    width: context.screenWidth * .9,
                    height: 72,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: context.secondaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.colors.white,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date"),
                        Text(
                          DateFormater.formatDateTime(
                              widget.appointment.booking.date),
                          style: context.textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    width: context.screenWidth * .9,
                    // height: 90,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: context.secondaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.colors.white,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Video Call link"),
                        AutoSizeText(
                          widget.appointment.booking.link?.isNotEmpty ??
                                  false ||
                                      widget.appointment.booking.link != null
                              ? widget.appointment.booking.link!
                              : "Link would be ready before the meeting time",
                          maxLines: 1,
                          maxFontSize: 16,
                          minFontSize: 9,
                          style: context.textTheme.titleLarge,
                        ),
                        const Gap(10),
                        if (widget.appointment.booking.link?.isNotEmpty ??
                            false)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.secondaryColor,
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.copy,
                                    color: context.primaryColor,
                                    size: 20,
                                  ),
                                  Text(
                                    "Copy Link",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ).withOnTap(() {
                            FlutterClipboard.copy(
                                    widget.appointment.booking.link!
                                    // ignore: avoid_print
                                    )
                                // ignore: use_build_context_synchronously
                                .then(
                                    (value) => context.showSnackBar("Copied"));
                          })
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      CustomTextButton(
                        label: "I have finished this session!",
                        textStyle: context.textTheme.bodyMedium
                            ?.copyWith(color: context.primaryColor),
                        onPressed: () {
                          // _showIntegrityCheckModal(context);
                          _showIntegrityCheckDialog(
                              context, widget.appointment);
                        },
                      )
                    ],
                  ).withCustomPadding()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showIntegrityCheckModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 32.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Integrity Check",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Enter the session code provided by the client ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: "e.g 123498",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showIntegrityCheckDialog(
      BuildContext context, AppointmentModel appointment) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false, // Change as needed
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return IntegrityCheck(
              controller: controller,
              appointmentModel: appointment,
            );
          },
        );
      },
    );
  }
}

class IntegrityCheck extends StatefulWidget {
  const IntegrityCheck({
    super.key,
    required this.controller,
    required this.appointmentModel,
  });

  final TextEditingController controller;
  final AppointmentModel appointmentModel;

  @override
  State<IntegrityCheck> createState() => _IntegrityCheckState();
}

class _IntegrityCheckState extends State<IntegrityCheck> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // Add padding that accounts for the keyboard height
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 32,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Integrity Check",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Enter the session code provided by the client ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: "e.g 123498",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {});
                    // If needed, call setState here to rebuild on typing
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(
                    label: "Done",
                    enable: widget.controller.text.isNotEmpty,
                    onPressed: () {
                      if (widget.controller.text.isNotEmpty) {
                        context.read<FinalizeBookingCubit>().finalizeBooking(
                            id: widget.appointmentModel.booking.id,
                            code: widget.controller.text);

                        context.pop();
                      }
                    }),
                Gap(2),
                CustomTextButton(
                    label: "cancel",
                    onPressed: () {
                      context.pop();
                    }),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
