import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

enum DentalServiceTypeEnum {
  all,
  scaling,
  cavityTreatment,
  wisdomTooth,
  periodontal,
  orthodontics,
  prosthodontics,
  cosmeticDental,
}

extension DentalServiceTypeExtension on DentalServiceTypeEnum {
  String get getDentalServiceTypeName {
    switch (this) {
      case DentalServiceTypeEnum.scaling:
        return "Cạo vôi răng & chăm sóc răng miệng";
      case DentalServiceTypeEnum.cavityTreatment:
        return "Điều trị răng sâu";
      case DentalServiceTypeEnum.wisdomTooth:
        return "Xử lý răng khôn";
      case DentalServiceTypeEnum.periodontal:
        return "Điều trị nha chu";
      case DentalServiceTypeEnum.orthodontics:
        return "Niềng răng - Chỉnh nha";
      case DentalServiceTypeEnum.prosthodontics:
        return "Phục hình răng giả";
      case DentalServiceTypeEnum.cosmeticDental:
        return "Dịch vụ thẩm mỹ răng";
      default:
        return "Tất cả dịch vụ";
    }
  }
}

@immutable
class DentalService extends Equatable {
  final int id;
  final String image;
  final String name;
  final DentalServiceTypeEnum type;
  final bool isFavorite;
  final bool addedToSchedule;

  const DentalService({
    required this.id,
    required this.image,
    required this.name,
    required this.type,
    this.isFavorite = false,
    this.addedToSchedule = false,
  });

  @override
  String toString() {
    return 'DentalService{id: $id, name: $name, type: $type, isFavorite: $isFavorite, addedToSchedule: $addedToSchedule}';
  }

  @override
  List<Object?> get props => [
    id,
    image,
    name,
    type,
    isFavorite,
    addedToSchedule,
  ];

  DentalService copyWith({
    int? id,
    String? image,
    String? name,
    DentalServiceTypeEnum? type,
    bool? isFavorite,
    bool? addedToSchedule,
  }) {
    return DentalService(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
      addedToSchedule: addedToSchedule ?? this.addedToSchedule,
    );
  }
}
