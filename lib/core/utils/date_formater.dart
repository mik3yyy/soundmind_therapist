import 'package:intl/intl.dart';

class DateFormater {
  static String formatDate(DateTime dateTime) {
    final year = dateTime.year;
    final month =
        dateTime.month.toString().padLeft(2, '0'); // Ensures two-digit month
    final day =
        dateTime.day.toString().padLeft(2, '0'); // Ensures two-digit day

    return '$year-$month-$day';
  }

  static String formatTimeRange(String startTimeStr, String endTimeStr) {
    // Parse the time strings into DateTime objects
    DateTime startTime = DateFormat("HH:mm:ss").parse(startTimeStr);
    DateTime endTime = DateFormat("HH:mm:ss").parse(endTimeStr);

    // Format them into the desired 12-hour format with lowercase AM/PM
    final DateFormat timeFormatter = DateFormat('h:mma');
    String formattedStartTime = timeFormatter.format(startTime).toLowerCase();
    String formattedEndTime = timeFormatter.format(endTime).toLowerCase();

    return '$formattedStartTime - $formattedEndTime';
  }

  static String formatDateTime(DateTime dateTime) {
    // Get the day of the month
    int day = dateTime.day;

    // Determine the suffix for the day
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Format the date string
    String formattedDate = DateFormat('EEE, d').format(dateTime) +
        suffix +
        DateFormat(' MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatTime(DateTime time) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    return timeFormatter.format(time);
  }

  static String formatTime2(DateTime time) {
    final DateFormat timeFormatter = DateFormat('HH:mm:ss');
    return timeFormatter.format(time);
  }

  static String? convertTime12hTo24h(String time12h) {
    try {
      // Define the input and output date formats
      final DateFormat inputFormat = DateFormat('hh:mm a');
      final DateFormat outputFormat = DateFormat('HH:mm:ss');

      // Parse the input time string to a DateTime object
      DateTime dateTime = inputFormat.parseStrict(time12h);

      // Format the DateTime object to the desired output format
      String time24h = outputFormat.format(dateTime);

      return time24h;
    } catch (e) {
      // Handle parsing errors
      print('Error parsing time "$time12h": $e');
      return null;
    }
  }
}
