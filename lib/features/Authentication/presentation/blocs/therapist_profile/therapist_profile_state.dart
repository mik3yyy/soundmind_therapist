part of 'therapist_profile_cubit.dart';

sealed class TherapistProfileState extends Equatable {
  const TherapistProfileState();

  @override
  List<Object> get props => [];
}

final class TherapistProfileInitial extends TherapistProfileState {}

final class GetInitialDataLoading extends TherapistProfileState {}

final class GetInitialDataLoaded extends TherapistProfileState {}

final class GetInitialDataFailure extends TherapistProfileState {}

final class TherapistProfileLoading extends TherapistProfileState {}

final class TherapistProfileSuccess extends TherapistProfileState {}

final class TherapistProfileFailue extends TherapistProfileState {
  final String message;

  TherapistProfileFailue({required this.message});
}
