import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:dental_care/src/data/model/dental_service.dart';

@immutable
class DentalServiceType extends Equatable {
  final DentalServiceTypeEnum type;
  final bool isSelected;

  const DentalServiceType({required this.type, required this.isSelected});

  DentalServiceType copyWith({DentalServiceTypeEnum? type, bool? isSelected}) {
    return DentalServiceType(
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [type, isSelected];

  @override
  String toString() {
    return '\nDentalServiceType{type: $type, isSelected: $isSelected}';
  }
}
