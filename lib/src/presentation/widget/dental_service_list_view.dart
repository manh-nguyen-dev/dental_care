import 'package:flutter/material.dart';

import 'package:dental_care/src/data/model/dental_service.dart';
import 'dental_service_item.dart';

class DentalServiceListView extends StatelessWidget {
  const DentalServiceListView({super.key, required this.dentalServices});
  final List<DentalService> dentalServices;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child:
          dentalServices.isEmpty
              ? Center(
                child: Text(
                  "Không có sản phẩm/ dịch vụ nào được tìm thấy",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.only(top: 20, left: 12),
                scrollDirection: Axis.horizontal,
                itemCount: dentalServices.length,
                itemBuilder: (_, index) {
                  return DentalServiceItem(
                    dentalServiceItem: dentalServices[index],
                  );
                },
                separatorBuilder: (_, __) {
                  return const Padding(padding: EdgeInsets.only(right: 16));
                },
              ),
    );
  }
}
