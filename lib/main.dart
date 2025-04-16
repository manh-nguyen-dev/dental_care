import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_care/src/data/repository/repository.dart';
import 'package:dental_care/src/presentation/screen/home_screen.dart';
import 'package:dental_care/src/business_logic/cubits/theme/theme_cubit.dart';
import 'package:dental_care/src/business_logic/cubits/theme/theme_state.dart';
import 'package:dental_care/src/business_logic/cubits/navigation/navigation_cubit.dart';
import 'package:dental_care/src/business_logic/cubits/dental_service_type/dental_service_type_cubit.dart';

import 'src/business_logic/cubits/dental_center/dental_center_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DentalServiceTypeCubit>(
            create:
                (context) => DentalServiceTypeCubit(
                  repository: context.read<Repository>(),
                ),
          ),
          BlocProvider<DentalCenterCubit>(create: (context) => DentalCenterCubit(repository: context.read<Repository>())),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
