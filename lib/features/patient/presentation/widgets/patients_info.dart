// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:soundmind_therapist/features/patient/presentation/blocs/get_patient_details/get_patient_details_cubit.dart';

// class PatientsInfo extends StatefulWidget {
//   const PatientsInfo({super.key});

//   @override
//   State<PatientsInfo> createState() => _PatientsInfoState();
// }

// class _PatientsInfoState extends State<PatientsInfo> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<GetPatientDetailsCubit, GetPatientDetailsState>(
//         builder: (context, state) {
//           var patient = (state as GetPatientDetailsSuccess).patient.;
//           return Container();
//         },
//       ),
//     );
//   }
// }
