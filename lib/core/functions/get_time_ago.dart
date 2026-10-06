import 'package:timeago/timeago.dart' as timeago;

String getTimeAgo(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }

  final dateTime = DateTime.parse(date);

  return timeago.format(
    dateTime,
    locale: 'ar',
  );
}
