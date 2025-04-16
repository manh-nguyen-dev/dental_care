import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business_logic/cubits/theme/theme_cubit.dart';
import '../widget/custom_page_route.dart';
import 'calendar_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.showNavBar = true});

  final bool showNavBar;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cài đặt",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: ListView(
        children: [
          _buildSystemSettingsSection(context),
          const SizedBox(height: 20),
          _buildAppointmentSettingsSection(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    void Function()? onTap,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Theme.of(context).hintColor),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildSystemSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Cài đặt hệ thống'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildListTile(
                context,
                title: 'Chế độ',
                onTap: () => _showThemeModePicker(context),
              ),
              const Divider(height: 1, indent: 16),
              _buildListTile(
                context,
                title: 'Ngôn ngữ',
                onTap:
                    () => _showLanguagePicker(
                      context,
                      title: 'Ngôn ngữ',
                      initialValue: 0,
                      onChanged: (int _) {},
                      unit: '',
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Cài đặt lịch hẹn'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildListTile(
                context,
                title: 'Xem lại các lịch hẹn đã đặt',
                onTap: () {
                  Navigator.push(context, CustomPageRoute(child: CalendarScreen()));
                },
              ),
              const Divider(height: 1, indent: 16),
              _buildListTile(context, title: 'Nhắc nhở lịch hẹn', onTap: () {}),
              const Divider(height: 1, indent: 16),
              _buildListTile(
                context,
                title: 'Hủy hoặc dời lịch hẹn',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 16),
              _buildListTile(
                context,
                title: 'Gửi email các dịch vụ, ưu đãi, lịch hẹn',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showThemeModePicker(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLightTheme = prefs.getBool('isLightTheme') ?? true;

    await showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Chọn chế độ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildThemeModeOption(
                  context,
                  title: 'Sáng',
                  icon: Icons.light_mode,
                  isLightTheme: isLightTheme,
                ),
                _buildThemeModeOption(
                  context,
                  title: 'Tối',
                  icon: Icons.dark_mode,
                  isLightTheme: !isLightTheme,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isLightTheme,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing:
          isLightTheme
              ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              : null,
      onTap: () {
        Navigator.pop(context);
        context.read<ThemeCubit>().switchTheme();
      },
    );
  }

  Future<void> _showLanguagePicker(
    BuildContext context, {
    required String title,
    required int initialValue,
    required void Function(int) onChanged,
    required String unit,
  }) async {
    var selectedValue = initialValue;

    await showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Huỷ'),
                    ),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        onChanged(selectedValue);
                        Navigator.pop(context);
                      },
                      child: const Text('Xong'),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (index) {
                      selectedValue = index;
                    },
                    scrollController: FixedExtentScrollController(
                      initialItem: initialValue,
                    ),
                    children: List.generate(
                      1,
                      (index) => Center(child: Text("Tiếng Việt")),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
