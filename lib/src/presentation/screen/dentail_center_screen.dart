import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_color.dart';
import '../../business_logic/cubits/dental_center/dental_center_cubit.dart';
import '../../data/model/dental_center.dart';

class DentalCenterScreen extends StatefulWidget {
  const DentalCenterScreen({super.key});

  @override
  State<DentalCenterScreen> createState() => _DentalCenterScreenState();
}

class _DentalCenterScreenState extends State<DentalCenterScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _provinceKeys = {};

  @override
  void initState() {
    super.initState();
    context.read<DentalCenterCubit>().getDentalCentersByProvince();
  }

  void _scrollToProvince(String province) {
    final keyContext = _provinceKeys[province]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách trung tâm nha khoa',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<DentalCenterCubit, DentalCenterState>(
            builder: (context, state) {
              if (state is DentalLoading) {

              }

              if (state is DentalLoaded) {
                // Lấy các tỉnh từ dữ liệu đã tải
                _provinceKeys.clear();
                state.dentalCentersByProvince.forEach((province, _) {
                  _provinceKeys[province] = GlobalKey();
                });

                return _buildProvinceSelector();
              }

              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: BlocBuilder<DentalCenterCubit, DentalCenterState>(
                builder: (context, state) {
                  if (state is DentalLoaded) {
                    final dentalCenters = state.dentalCentersByProvince;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dentalCenters.entries.map((entry) {
                        return _buildProvinceSection(
                          entry.key,
                          entry.value,
                        );
                      }).toList(),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceSelector() {
    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _provinceKeys.keys.map((province) {
          return GestureDetector(
            onTap: () => _scrollToProvince(province),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: LightThemeColor.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  province,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProvinceSection(String province, List<DentalCenter> centers) {
    return Column(
      key: _provinceKeys[province],
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            province,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children:
          centers.map((center) => _buildDentalCenterTile(center)).toList(),
        ),
      ],
    );
  }

  Widget _buildDentalCenterTile(DentalCenter center) {
    return Align(
      alignment: Alignment.topLeft,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                center.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Địa chỉ: ${center.address}',
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                'Giờ mở cửa: ${center.openingHours}',
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                'Hotline: ${center.hotline}',
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
