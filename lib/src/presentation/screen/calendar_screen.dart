import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widget/date_scroll_picker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, this.showNavBar = true});

  final bool showNavBar;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarView _calendarView = CalendarView.day;
  final CalendarController _calendarController = CalendarController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarKey = ValueKey('calendar-$_calendarView');

    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch', style: Theme.of(context).textTheme.displayMedium),
        actions: [
          PopupMenuButton<CalendarView>(
            icon: const Icon(Icons.menu),
            tooltip: 'Calendar View',
            onSelected: (CalendarView view) {
              setState(() {
                _calendarView = view;
                _calendarController.view = view;
                if (view == CalendarView.day) {
                  _calendarController.displayDate = _selectedDate;
                }
              });
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<CalendarView>>[
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.day,
                    child: Text('Day View'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.month,
                    child: Text('Month View'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_calendarView == CalendarView.day)
            DateScrollPicker(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _calendarController.displayDate = date;
                });
              },
            ),
          Expanded(
            child: SfCalendar(
              key: calendarKey,
              controller: _calendarController,
              view: _calendarView,
              headerHeight: _calendarView == CalendarView.day ? 0 : 40,
              viewHeaderHeight: _calendarView == CalendarView.day ? 0 : 60,
              firstDayOfWeek: 1,
              monthViewSettings: MonthViewSettings(
                showAgenda: true,
                agendaViewHeight: 200,
                monthCellStyle: MonthCellStyle(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 11),
                ),
              ),
              weekNumberStyle: WeekNumberStyle(
                textStyle: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 11),
              ),
              timeSlotViewSettings: TimeSlotViewSettings(
                timeFormat: 'h:mm a',
                timeIntervalHeight: 60,
                timeTextStyle: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 11),
              ),
              appointmentBuilder: _buildAppointment,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointment(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    return const SizedBox.shrink();
  }
}
