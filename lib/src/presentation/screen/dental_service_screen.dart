import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_care/core/app_color.dart';
import 'package:dental_care/src/data/model/dental_service.dart';

import '../widget/dental_service_list_view.dart';
import '../../data/model/dental_service_type.dart';
import '../../business_logic/cubits/dental_service_type/dental_service_type_cubit.dart';

class DentalServiceScreen extends StatefulWidget {
  const DentalServiceScreen({super.key});

  @override
  State<DentalServiceScreen> createState() => _DentalServiceScreenState();
}

class _DentalServiceScreenState extends State<DentalServiceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Sản phẩm/ Dịch vụ",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DentalServiceTypeCubit>();
    final List<DentalServiceType> categories = cubit.state.types;
    final List<DentalService> allServices = cubit.state.dentalServiceList;

    final List<DentalService> filteredServices =
        allServices
            .where(
              (service) => service.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm, dịch vụ',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.all(20),
                suffixIcon:
                    _searchQuery.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchQuery = "";
                              _searchController.clear();
                            });
                          },
                        )
                        : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  DentalServiceType category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<DentalServiceTypeCubit>().filterItemByType(
                        category,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            category.isSelected
                                ? LightThemeColor.accent
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.type.getDentalServiceTypeName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              ),
            ),
          ),
          DentalServiceListView(dentalServices: filteredServices),
          // Padding(
          //   padding: const EdgeInsets.only(top: 25, bottom: 5, left: 12),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Các dịch vụ được sử dụng gần đây",
          //         style: Theme.of(context).textTheme.displaySmall,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 20),
          //         child: Text(
          //           "Xem tất cả",
          //           style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          //             color: LightThemeColor.accent,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
