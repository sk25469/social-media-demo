import 'package:cloud_firestore/cloud_firestore.dart';

Map<int, String> monthDateToName = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sept",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

String toReadableDate(Timestamp timestamp) {
  var day = timestamp.toDate().day;
  var month = monthDateToName[timestamp.toDate().month];
  var year = (timestamp.toDate().year) % 100;
  return '${day}th $month\' $year';
}

String toReadableTime(Timestamp timestamp) {
  var hour = timestamp.toDate().hour;
  var minute = timestamp.toDate().minute;
  var ampm = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour;
  return '$hour:$minute $ampm';
}

String durationAgo(Timestamp timestamp) {
  var now = DateTime.now();
  var diff = now.difference(timestamp.toDate());
  var days = diff.inDays;
  var hours = diff.inHours;
  var minutes = diff.inMinutes;
  var seconds = diff.inSeconds;
  if (days > 0) {
    return '$days days ago';
  } else if (hours > 0) {
    return '$hours hours ago';
  } else if (minutes > 0) {
    return '$minutes minutes ago';
  } else {
    return '$seconds seconds ago';
  }
}
