import 'package:dental_care/core/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_color.dart';
import '../../../utils/colors.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đặt lịch",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                child: Text(
                  "NHẬN TƯ VẤN MIỄN PHÍ TỪ BÁC SĨ",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium,
                ).fadeAnimation(0.2),
              ),
              const SizedBox(height: 12),
              Align(
                child: Text(
                  "ĐẶT LỊCH THĂM KHÁM NGAY",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge,
                ).fadeAnimation(0.2),
              ),
              const SizedBox(height: 40),
              TextFormField(
                text: "Họ và tên",
                iconPath: "assets/icons/user.svg",
              ),
              const SizedBox(height: 24),
              TextFormField(
                text: "Số điện thoại",
                keyboardType: TextInputType.phone,
                iconPath: "assets/icons/phone-rounded.svg",
              ),
              SizedBox(height: 24),
              CheckboxList(),
              InputTextBoxBigger(
                text: "Tình trạng răng/ nội dung cần tư vấn?",
                iconPath: "assets/icons/content-left.svg",
              ),
              SizedBox(height: 24),
              ButtonPlainWithIcon(
                color: LightThemeColor.accent,
                textColor: white,
                iconPath: "assets/icons/arrow_next.svg",
                isSuffix: true,
                text: "Gửi Yêu Cầu",
                callback: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonPlainWithIcon extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback callback;
  final bool isSuffix;
  final Color color;
  final Color textColor;
  final double? size;

  const ButtonPlainWithIcon({
    super.key,
    required this.text,
    required this.callback,
    required this.isSuffix,
    required this.iconPath,
    required this.color,
    this.size,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: size != null ? size! : MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            if (isSuffix)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(iconPath),
              ),
          ],
        ),
      ),
    );
  }
}

class InputTextBoxBigger extends StatelessWidget {
  final String text;
  final String iconPath;

  const InputTextBoxBigger({
    super.key,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: Theme.of(context).textTheme.titleLarge,
          contentPadding: EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: .5, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: .5, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: .5, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: .5, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          prefixIcon: Container(
            height: 128,
            width: 48,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 16.0),
              child: SvgPicture.asset(
                iconPath,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormField extends StatelessWidget {
  final String text;
  final String iconPath;
  final TextInputType? keyboardType;

  const TextFormField({
    super.key,
    required this.text,
    required this.iconPath,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: Theme.of(context).textTheme.titleLarge,
        contentPadding: EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5, color: black),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5, color: black),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5, color: black),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: .5, color: black),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

class CheckboxList extends StatefulWidget {
  const CheckboxList({super.key});

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  List<String> options = [
    "Răng sứ",
    "Trồng răng Implant",
    "Niềng răng",
    "Nhổ răng",
    "Tẩy trắng răng",
    "Điều trị bệnh lý răng",
    "Khác",
  ];

  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor, width: .25),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            "Dịch vụ/tình trạng cần tư vấn",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Column(
            children:
                options.map((option) {
                  return CheckboxListTile(
                    title: Text(
                      option,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    value: selectedOptions.contains(option),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedOptions.add(option);
                        } else {
                          selectedOptions.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
