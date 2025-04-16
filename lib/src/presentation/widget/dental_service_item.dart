import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_care/core/app_color.dart';
import 'package:dental_care/core/app_extension.dart';
import 'package:dental_care/src/data/model/dental_service.dart';
import 'package:dental_care/src/business_logic/cubits/theme/theme_cubit.dart';
import '../screen/dental_service_detail.dart';
import 'custom_page_route.dart';

class DentalServiceItem extends StatelessWidget {
  const DentalServiceItem({super.key, required this.dentalServiceItem});

  final DentalService dentalServiceItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: DentalServiceDetailScreen(service: dentalServiceItem),
          ),
        );
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              context.read<ThemeCubit>().isLightTheme
                  ? Colors.white
                  : DarkThemeColor.primaryLight,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                dentalServiceItem.image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Text(
                  dentalServiceItem.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                ),
              ),
            ],
          ).fadeAnimation(0.5),
        ),
      ),
    );
  }
}
