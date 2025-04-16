part of 'dental_service_type_cubit.dart';

@immutable
class DentalServiceTypeState extends Equatable {
  final List<DentalServiceType> types;
  final List<DentalService> dentalServiceList;

  const DentalServiceTypeState.initial(
      List<DentalService> foodList, List<DentalServiceType> foodCategories)
      : this(dentalServiceList: foodList, types: foodCategories);

  const DentalServiceTypeState({
    required this.types,
    required this.dentalServiceList,
  });

  @override
  List<Object?> get props => [types, dentalServiceList];

  DentalServiceTypeState copyWith({
    List<DentalServiceType>? types,
    List<DentalService>? dentalServiceList,
  }) {
    return DentalServiceTypeState(
      types: types ?? this.types,
      dentalServiceList: dentalServiceList ?? this.dentalServiceList,
    );
  }
}
