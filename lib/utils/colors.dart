import 'package:flutter/material.dart';

const white = Color(0xFFFFFFFF);
const flamingo = Color(0xFFF95A2C);
const black = Color(0xFF000000);
const trout = Color(0xFF474A57);
const dandelion = Color(0xFFFFD465);
const foam = Color(0xFFD6FCF7);

class ColorUtil {
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO(
      (hex & 0xFF0000) >> 16,
      (hex & 0x00FF00) >> 8,
      (hex & 0x0000FF) >> 0,
      alpha,
    );
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(
      int.parse(buffer.toString().replaceAll('0x00', '0xff'), radix: 16),
    );
  }

  static Color fromDecimal(String? num) {
    try {
      if (!(num != null && num.isNotEmpty)) {
        return ColorUtil.fromHex('FFFFFF');
      }
      return ColorUtil.fromHex(int.parse(num.toString(), radix: 16).toString());
    } catch (e) {
      return ColorUtil.fromHex('FFFFFF');
    }
  }
}
