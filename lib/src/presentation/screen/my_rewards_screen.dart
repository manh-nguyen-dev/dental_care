import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRewardsScreen extends StatefulWidget {
  const MyRewardsScreen({super.key});

  @override
  State<MyRewardsScreen> createState() => _MyRewardsScreenState();
}

class _MyRewardsScreenState extends State<MyRewardsScreen> {
  DateTime today = DateTime.now();
  List<String> weekDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
  List<DateTime> weekDates = [];
  int streakCount = 0;
  bool rewardClaimed = false;
  String lastClaimedDate = "";
  List<Map<String, String>> vouchers = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadStreakCount();
    _generateWeekDates();
    _loadVouchers();
  }

  void _loadStreakCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      streakCount = prefs.getInt('streakCount') ?? 0;
      lastClaimedDate = prefs.getString('lastClaimedDate') ?? "";
      rewardClaimed = lastClaimedDate == DateFormat('yyyy-MM-dd').format(today);
    });
  }

  void _generateWeekDates() {
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    for (int i = 0; i < 7; i++) {
      weekDates.add(startOfWeek.add(Duration(days: i)));
    }
  }

  void _loadVouchers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedVouchers = prefs.getStringList('vouchers');

    if (savedVouchers != null) {
      setState(() {
        vouchers =
            savedVouchers.map((v) {
              List<String> data = v.split('|');
              return {"code": data[0], "date": data[1]};
            }).toList();
      });
    }
  }

  Future<void> _claimReward() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String todayStr = DateFormat('yyyy-MM-dd').format(today);

    setState(() {
      rewardClaimed = true;
      streakCount += 1;
      lastClaimedDate = todayStr;
    });

    await prefs.setInt('streakCount', streakCount);
    await prefs.setString('lastClaimedDate', todayStr);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Phần thưởng"),
          content: Text("Bạn đã nhận được 100 xu!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String _generateVoucherCode() {
    ///TODO: Update generate a voucher code by making an HTTP request to the backend
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  void _redeemVoucher() async {
    if (streakCount < 7) return;

    String newVoucher = _generateVoucherCode();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    setState(() {
      vouchers.add({"code": newVoucher, "date": today});
      streakCount -= 7;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedVouchers =
        vouchers.map((v) => "${v['code']}|${v['date']}").toList();
    await prefs.setStringList('vouchers', savedVouchers);
    await prefs.setInt('streakCount', streakCount);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quà của tôi",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          Text(
            "Điểm danh hàng ngày",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          Text(
            "Chuỗi điểm danh: $streakCount ngày",
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontSize: 14),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                bool isToday =
                    DateFormat('yyyy-MM-dd').format(weekDates[index]) ==
                    DateFormat('yyyy-MM-dd').format(today);
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        weekDays[index],
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          fontSize: 11,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday ? Colors.blue : Colors.grey[700],
                            ),
                            child: Text(
                              "${weekDates[index].day}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed:
                              isToday && !rewardClaimed ? _claimReward : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            "Nhận",
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge?.copyWith(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: streakCount >= 7 ? _redeemVoucher : null,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              "Đổi voucher (7 điểm)",
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: 14),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Danh sách voucher đã đổi:",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.card_giftcard, color: Colors.grey),
                    title: Text(
                      "Mã: ${vouchers[index]['code']}",
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(fontSize: 14),
                    ),
                    subtitle: Text(
                      "Ngày: ${vouchers[index]['date']}",
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(fontSize: 14),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Theo dõi chúng tôi trên các nền tảng để nhận các ưu đãi/ quà tặng sớm",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_instagram.svg",
                        colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_facebook.svg",
                        colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_tiktok.svg",
                        colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
