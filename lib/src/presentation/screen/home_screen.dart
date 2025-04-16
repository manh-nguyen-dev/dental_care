import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dental_care/core/app_data.dart';
import 'package:dental_care/src/presentation/screen/dental_service_screen.dart';
import 'package:dental_care/src/presentation/screen/my_rewards_screen.dart';
import 'package:dental_care/src/presentation/screen/booking_screen.dart';
import 'package:dental_care/src/presentation/screen/dashboard_screen.dart';
import 'package:dental_care/src/presentation/animation/page_transition.dart';

import '../../business_logic/cubits/navigation/navigation_cubit.dart';
import 'dentail_center_screen.dart';

class HomeScreen extends HookWidget {
  HomeScreen({super.key});

  final List<Widget> screen = [
    const DashboardScreen(),
    const DentalServiceScreen(),
    const DentalCenterScreen(),
    const BookingScreen(),
    const MyRewardsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, selectedIndex) {
          return PageTransition(child: screen[selectedIndex]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavigationCubit>().state,
        onTap: (index) => context.read<NavigationCubit>().setTab(index),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items:
            AppData.bottomNavigationItems.map((element) {
              return BottomNavigationBarItem(
                icon:
                    element.label == ''
                        ? Container(
                          alignment: Alignment.center,
                          height: 32,
                          child: Transform.scale(
                            scale: 3,
                            child: element.disableIcon,
                          ),
                        )
                        : element.disableIcon,
                label: element.label,
                activeIcon:
                    element.label == ''
                        ? Container(
                          alignment: Alignment.center,
                          height: 32,
                          child: Transform.scale(
                            scale: 3,
                            child: element.enableIcon,
                          ),
                        )
                        : element.enableIcon,
              );
            }).toList(),
      ),
    );
  }
}
