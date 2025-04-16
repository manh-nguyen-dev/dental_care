import 'package:dental_care/core/app_navigation.dart';
import 'package:flutter/material.dart' hide Badge;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:dental_care/core/app_asset.dart';
import 'package:dental_care/core/app_color.dart';
import 'package:dental_care/core/app_extension.dart';
import 'settings_screen.dart';
import '../widget/greeting_widget.dart';
import '../widget/custom_page_route.dart';
import '../../business_logic/cubits/navigation/navigation_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          AppAsset.logo,
          width: 140,
          height: 60,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _navigateToServiceScreen(context),
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: Badge(
        //     badgeStyle: const BadgeStyle(badgeColor: LightThemeColor.accent),
        //     badgeContent: const Text(
        //       "2",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     position: BadgePosition.topStart(start: -3),
        //     child: const Icon(Icons.shopping_cart_outlined, size: 30),
        //   ),
        // ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.sliders),
          onPressed: () {
            if (!context.mounted) {
              return;
            }
            Navigator.push(context, CustomPageRoute(child: SettingsScreen()));
          },
        ),
      ],
    );
  }

  void _navigateToCenterScreen(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    context.read<NavigationCubit>().setTab(
      NavigationEnum.values.indexOf(NavigationEnum.center),
    );
  }

  void _navigateToRewardsScreen(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    context.read<NavigationCubit>().setTab(
      NavigationEnum.values.indexOf(NavigationEnum.rewards),
    );
  }

  void _navigateToServiceScreen(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    context.read<NavigationCubit>().setTab(
      NavigationEnum.values.indexOf(NavigationEnum.services),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingScreen(),
              Text(
                "Bạn đang muốn tìm kiếm điều gì từ chúng tôi!",
                style: Theme.of(context).textTheme.displayLarge,
              ).fadeAnimation(0.4),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    context.read<NavigationCubit>().setTab(
                      NavigationEnum.values.indexOf(NavigationEnum.services),
                    );
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Tìm sản phẩm, dịch vụ',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: .25),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.asset(AppAsset.dentalCareBanner),
                    ),
                    const SizedBox(height: 18.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<NavigationCubit>().setTab(
                            NavigationEnum.values.indexOf(
                              NavigationEnum.services,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightThemeColor.accent,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Tìm hiểu thêm',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: .25),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.asset(AppAsset.accumulationOfPoint),
                    ),
                    const SizedBox(height: 18.0),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _navigateToRewardsScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightThemeColor.accent,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Tìm hiểu thêm',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () => _navigateToCenterScreen,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: .25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.lightbulb,
                        size: 24,
                        color: LightThemeColor.accent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tìm trung tâm',
                        style: TextStyle(
                          color: LightThemeColor.accent,
                          fontSize: 18.0,
                        ),
                      ),
                      const Spacer(),
                      const FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: 24,
                        color: LightThemeColor.accent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/images/8thang3.png'),
            ],
          ),
        ),
      ),
    );
  }
}
