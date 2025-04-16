import 'package:dental_care/src/data/model/dental_center.dart';
import 'package:dental_care/src/data/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dental_center_state.dart';

class DentalCenterCubit extends Cubit<DentalCenterState> {
  DentalCenterCubit({required this.repository}) : super(DentalInitial());

  Repository repository;

  void getDentalCentersByProvince() {
    emit(DentalLoading());

    final Map<String, List<DentalCenter>> dentalCentersByProvince =
        repository.getDentalCentersByProvince;

    emit(DentalLoaded(dentalCentersByProvince));
  }
}
