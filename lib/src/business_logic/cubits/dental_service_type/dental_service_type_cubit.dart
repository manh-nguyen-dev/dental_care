import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:dental_care/src/data/model/dental_service.dart';
import 'package:dental_care/src/data/model/dental_service_type.dart';
import 'package:dental_care/src/data/repository/repository.dart';

part 'dental_service_type_state.dart';

class DentalServiceTypeCubit extends Cubit<DentalServiceTypeState> {
  Repository repository;

  DentalServiceTypeCubit({required this.repository})
    : super(
        DentalServiceTypeState.initial(
          repository.getDentalServiceItems,
          repository.getCategories,
        ),
      );

  filterItemByType(DentalServiceType typeItem) {
    final List<DentalServiceType> types =
        state.types.map((element) {
          if (element == typeItem) {
            return typeItem.copyWith(isSelected: true);
          }
          return element.copyWith(isSelected: false);
        }).toList();

    if (typeItem.type == DentalServiceTypeEnum.all) {
      emit(
        DentalServiceTypeState(
          types: types,
          dentalServiceList: repository.getDentalServiceItems,
        ),
      );
    } else {
      final List<DentalService> dentalServiceList =
          repository.getDentalServiceItems
              .where((item) => item.type == typeItem.type)
              .toList();
      emit(state.copyWith(dentalServiceList: dentalServiceList, types: types));
    }
  }
}
