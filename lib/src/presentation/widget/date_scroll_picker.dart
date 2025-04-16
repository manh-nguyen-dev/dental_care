import 'package:dental_care/core/app_color.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateScrollPicker extends StatefulWidget {
  const DateScrollPicker({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  @override
  State<DateScrollPicker> createState() => _DateScrollPickerState();
}

class _DateScrollPickerState extends State<DateScrollPicker> {
  late ScrollController _scrollController;
  late List<DateTime> _dates;
  final int _totalDays = 60;
  final double _itemWidth = 70;
  final double _itemHeight = 92;
  late int _initialIndex;

  @override
  void initState() {
    super.initState();

    // Create a list of dates (30 days before and after today)
    final today = DateTime.now();
    _dates = List.generate(
      _totalDays,
          (index) => DateTime(
        today.year,
        today.month,
        today.day - (_totalDays ~/ 2) + index,
      ),
    );

    // Find the index of the selected date
    _initialIndex = _dates.indexWhere(
          (date) => isSameDay(date, widget.selectedDate),
    );

    // Default to today if the selected date is not in range
    if (_initialIndex < 0) {
      _initialIndex = _totalDays ~/ 2;
    }

    // Initialize the scroll controller to the selected date
    _scrollController = ScrollController(
      initialScrollOffset: _initialIndex * _itemWidth,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: _itemHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemExtent: _itemWidth,
          itemCount: _dates.length,
          itemBuilder: (context, index) {
            final date = _dates[index];
            final isSelected = isSameDay(date, widget.selectedDate);
            final isToday = isSameDay(date, DateTime.now());

            // Formatting
            final weekdayFormat = DateFormat('E'); // Mon, Tue, etc.
            final dayFormat = DateFormat('d'); // 1, 2, etc.
            final monthFormat = DateFormat('MMM'); // Jan, Feb, etc.

            return GestureDetector(
              onTap: () => widget.onDateSelected(date),
              child: Container(
                width: _itemWidth,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                      isSelected
                          ? LightThemeColor.accent
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _itemHeight - 2,
                      maxHeight: _itemHeight - 2,
                      minWidth: _itemWidth - 4,
                      maxWidth: _itemWidth - 4,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          weekdayFormat.format(date).toUpperCase(),
                          style: TextStyle(
                            fontSize: 13,
                            height: 1,
                            fontWeight: FontWeight.w500,
                            color:
                            isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                            isSelected
                                ? LightThemeColor.accent
                                : isToday
                                ? (isDarkMode
                                ? Colors.red[800]
                                : Colors.grey[200])
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              dayFormat.format(date),
                              style: TextStyle(
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.bold,
                                color:
                                isSelected
                                    ? Theme.of(
                                  context,
                                ).colorScheme.onPrimary
                                    : isToday
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(
                                  context,
                                ).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            monthFormat.format(date),
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color:
                              isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface
                                  .withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}