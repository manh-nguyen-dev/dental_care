part of 'dental_center_cubit.dart';

abstract class DentalCenterState extends Equatable {
  const DentalCenterState();

  @override
  List<Object?> get props => [];
}

class DentalInitial extends DentalCenterState {}

class DentalLoading extends DentalCenterState {}

class DentalLoaded extends DentalCenterState {
  final Map<String, List<DentalCenter>> dentalCentersByProvince;

  const DentalLoaded(this.dentalCentersByProvince);

  @override
  List<Object?> get props => [dentalCentersByProvince];
}
