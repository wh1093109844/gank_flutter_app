class DateTools {
  static String duration(DateTime after, DateTime before) {
    Duration duration = after.difference(before);
    String str = '';
    if (duration.inDays >= 365) {
      str = '${(duration.inDays / 365).toInt()}年前';
    } else if (duration.inDays >= 30) {
      str = '${(duration.inDays / 30).toInt()}月前';
    } else if (duration.inDays > 1) {
      str = '${duration.inDays}天前';
    } else if (duration.inDays == 1) {
      str = '昨天';
    } else if (duration.inHours > 0) {
      str = '${duration.inHours}小时前';
    } else if (duration.inMinutes > 30) {
      str = '半小时前';
    } else if (duration.inMinutes > 0) {
      str = '${duration.inMinutes}分钟前';
    } else {
      str = '刚刚';
    }
    return str;
  }
}
