import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/gen/fonts.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/core/utils/image_util.dart';
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
import 'package:sound_mind/core/widgets/custom_text_button.dart';
import 'package:sound_mind/core/widgets/error_screen.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_blogs.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/blogs/blogs_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor/doctor_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/upcoming_appointment/upcoming_appointment_cubit.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/view_blog.dart';
import 'package:sound_mind/features/main/presentation/widgets/blog_view.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<UpcomingAppointmentCubit>().state;
    if (state is! UpcomingAppointmentsLoaded) {
      context.read<UpcomingAppointmentCubit>().fetchUpcomingAppointments();
    }
    if (state is! BlogsSuccess) {
      context.read<BlogsCubit>().getBlogsEvent();
    }

    var doctorState = context.read<DoctorCubit>().state;
    if (doctorState is DoctorLoaded || doctorState is DoctorLoading) {
      if (doctorState is DoctorLoaded) {
        context.read<DoctorCubit>().chnageState(search: '');
      }
    } else {
      context.read<DoctorCubit>().fetchDoctors(pageNumber: 1, pageSize: 100);
    }
    // context.read<UpcomingAppointmentCubit>().fetchUpcomingAppointments();
  }

//disclaimer, imfo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            context.read<UpcomingAppointmentCubit>().fetchUpcomingAppointments();
            Constants.delayed();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  Column(
                    children: [
                      _appointmentSection(),
                      _therapistSection(),
                      _blogSection(),
                      _featuresSection(context).withCustomPadding(),
                    ],
                  )
                ],
              ),
            ),
          )),
      backgroundColor: context.colors.lilly4,
    );
  }

  Column _featuresSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: 190,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.white,
              ),
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Find Therapist",
                    style: context.textTheme.titleLarge,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.application.assets.svgs.findTherapistSc.svg(),
                      CircleAvatar(
                        backgroundColor: context.secondaryColor,
                        radius: 20,
                        child: Icon(
                          Icons.arrow_forward,
                          color: context.primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ).withOnTap(() {
              context.goNamed(Routes.findADocName);
            }).withExpanded(),
            const Gap(20),
            Container(
              // width: 190,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.white,
              ),
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Resources to boost your\nfeelings",
                    style: context.textTheme.titleLarge?.copyWith(height: 1.2),
                    maxLines: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.secondaryColor,
                        radius: 20,
                        child: Icon(
                          Icons.arrow_forward,
                          color: context.primaryColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ).withOnTap(() {
              // context.goNamed(Routes.blogName);
            }).withExpanded(),
          ],
        ),
      ],
    );
  }

  BlocBuilder<BlogsCubit, BlogsState> _blogSection() {
    return BlocBuilder<BlogsCubit, BlogsState>(
      builder: (context, state) {
        if (state is BlogsSuccess) {
          var blogs = state.blogs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Blogs",
                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  // CustomTextButton(label: "", onPressed: () {}),
                ],
              ),
              const Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blogs
                      .map<Widget>(
                        (blog) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BlogScreen(blog: blog)));
                            },
                            child: BlogView(title: blog.title, imageUrl: blog.imageUrl),
                          );
                        },
                      )
                      .toList()
                      .addSpacer(
                        Gap(20),
                      ),
                ),
              ),
              // const Gap(20),
            ],
          ).withCustomPadding();
        } else if (state is GetBlogs) {
          return ComplexShimmer.titleWithCardShimmer(
            itemCount: 1,
          ).withCustomPadding();
        } else if (state is UpcomingAppointmentError) {
          return SizedBox.fromSize();
        } else if (state is UpcomingAppointmentEmpty) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<DoctorCubit, DoctorState> _therapistSection() {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoaded) {
          List<DoctorModel> doctors = state.doctors.take(3).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Therapist",
                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  CustomTextButton(
                      label: "See all",
                      onPressed: () {
                        context.goNamed(Routes.findADocName);
                      }),
                ],
              ),
              // const Gap(10),
              Column(
                  // height: 150,
                  children: doctors
                      .map<Widget>(
                        (doctor) {
                          return ListTile(
                            onTap: () {
                              context.goNamed(Routes.view_docName, extra: doctor.physicianId);
                            },
                            leading: CachedNetworkImage(
                              imageUrl: doctor.profilePicture!,
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                            ).withClip(12),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "${doctor.lastName} ${doctor.firstName}".toLowerCase(),
                                  // .capitalizeAllFirst,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Assets.application.assets.svgs.star.svg(),
                                    Text(
                                      " ${doctor.ratingAverage} ",
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "| ${doctor.yoe}yrs experience",
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ), //₦15,000
                                  ],
                                ),
                                Text(
                                  "₦${doctor.consultationRate}/ session",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                      .toList()
                      .addSpacer(Gap(20))), // const Gap(20),
            ],
          ).withCustomPadding();
        } else if (state is DoctorLoading) {
          return SizedBox.fromSize();

          // return ComplexShimmer.titleWithCardShimmer(
          //   itemCount: 1,
          // ).withCustomPadding();
        } else if (state is DoctorError) {
          return SizedBox.fromSize();
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<UpcomingAppointmentCubit, UpcomingAppointmentState> _appointmentSection() {
    return BlocBuilder<UpcomingAppointmentCubit, UpcomingAppointmentState>(
      builder: (context, state) {
        if (state is UpcomingAppointmentsLoaded) {
          var doc = state.upcomingAppointments[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming session",
                style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  context.goNamed(Routes.viewSessionName, extra: doc);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: context.screenWidth * .9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: context.primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: doc.profilePicture ?? ImageUtils.profile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ).withClip(4),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                doc.therapistName,
                                style: context.textTheme.displayMedium?.copyWith(
                                  color: context.colors.white,
                                ),
                              ),
                              AutoSizeText(
                                doc.areaOfSpecialization ?? "",
                                style: context.textTheme.bodyMedium?.copyWith(color: context.colors.white),
                              ),
                              Text(
                                "Google Meet",
                                style: context.textTheme.titleLarge?.copyWith(
                                  color: context.colors.white,
                                ),
                              )
                            ],
                          ).withExpanded()
                        ],
                      ),
                      Gap(10),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.purple[900]?.withOpacity(.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: context.colors.white,
                                ),
                                const Gap(5),
                                Text(
                                  DateFormater.formatTimeRange(doc.schedule.startTime, doc.schedule.endTime),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: context.colors.white,
                                ),
                                const Gap(5),
                                Text(
                                  DateFormater.formatDateTime(
                                    doc.booking.date,
                                  ),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Gap(20),
            ],
          ).withCustomPadding();
        } else if (state is UpcomingAppointmentLoading) {
          return ComplexShimmer.cardShimmer(itemCount: 1, margin: const EdgeInsets.symmetric(vertical: 20))
              .withCustomPadding();
        } else if (state is UpcomingAppointmentError) {
          return SizedBox.fromSize();
          // return CustomErrorScreen(
          //   message: state.message,
          //   onTap: () {
          //     context
          //         .read<UpcomingAppointmentCubit>()
          //         .fetchUpcomingAppointments();
          //   },
          // );
        } else if (state is UpcomingAppointmentEmpty) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<AuthenticationBloc, AuthenticationState> _header() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        var user = (state as UserAccount).user;
        return Container(
          // height: context.screenHeight * .3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: const [.9, 1],
                colors: [context.secondaryColor, context.colors.white],
                begin: Alignment.bottomLeft,
                end: Alignment.topLeft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: ImageUtils.profile,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 60,
                    ),
                  ),
                ).withOnTap(() {
                  context.goNamed(Routes.settingsName);
                }),
                titleSpacing: 3,
                centerTitle: false,
                leadingWidth: 40,
                title: Text("Hello, ${user.firstName}"),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(Routes.notificationName);
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: context.colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(Routes.view_bookingName);
                    },
                    icon: Assets.application.assets.svgs.booking.svg(),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                "How are you feeling today?",
                style: context.textTheme.titleMedium
                    ?.copyWith(fontFamily: FontFamily.playfairDisplay, fontSize: 25, fontWeight: FontWeight.w200),
              ),
              Wrap(
                spacing: 5,
                children: ["Happy", "Sad", "Energetic", "Just a little down", "Anxious", "Relaxed"]
                    .map(
                      (e) => Chip(
                        backgroundColor: context.colors.lilly4,
                        label: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const Gap(20),
            ],
          ).withCustomPadding(),
        );
      },
    );
  }
}
