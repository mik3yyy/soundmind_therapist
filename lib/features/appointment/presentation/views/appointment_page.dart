import 'package:flutter/material.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/features/appointment/presentation/views/appointments_tab.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          bottom: TabBar(
            labelColor: context.primaryColor,
            indicatorColor: context.primaryColor,
            unselectedLabelColor: context.colors.black,
            tabs: const [
              Tab(text: 'Session'),
              Tab(text: 'Appointments'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UpcomingAppointmentsTab(),
            AcceptedAppointmentsTab(),
          ],
        ),
      ),
    );
  }
}

class UpcomingAppointmentsTab extends StatelessWidget {
  const UpcomingAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Upcoming Appointments',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
