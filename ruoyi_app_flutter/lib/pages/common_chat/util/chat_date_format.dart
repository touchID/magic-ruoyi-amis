import 'package:intl/intl.dart';

class ChatDateFormat {

  static String format(int millisecondsSinceEpoch, {bool dayOnly = true}) {
    DateTime nowDate = DateTime.now();
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String prefix = "";
    if (nowDate.year != targetDate.year) {
      prefix = DateFormat("yyyy年M月d日").format(targetDate);
    } else if (nowDate.month != targetDate.month) {
      prefix = DateFormat("M月d日").format(targetDate);
    } else if (nowDate.day != targetDate.day) {
      if (nowDate.day - targetDate.day == 1) {
        prefix = '昨日';
      } else {
        prefix = DateFormat("M月d日").format(targetDate);
      }
    }
    if (prefix.isNotEmpty && dayOnly) {
      return prefix;
    }
    int targetHour = targetDate.hour;
    String returnTime = "", suffix = DateFormat("h:mm").format(targetDate);
    if (targetHour >= 0 && targetHour < 6) {
      returnTime = '深夜';
    } else if (targetHour >= 6 && targetHour < 8) {
      returnTime = '早朝';
    } else if (targetHour >= 8 && targetHour < 11) {
      returnTime = '午前';
    } else if (targetHour >= 11 && targetHour < 13) {
      returnTime = '正午';
    } else if (targetHour >= 13 && targetHour < 18) {
      returnTime = '午後';
    } else if (targetHour >= 18 && targetHour <= 23) {
      returnTime = '夜';
    }
    return '$prefix $returnTime$suffix';
  }

  static String formatYMd(int millisecondsSinceEpoch) {
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat("yyy/M/d").format(targetDate);
  }

  static String formatMd(int millisecondsSinceEpoch) {
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat("M-d").format(targetDate);
  }
}
