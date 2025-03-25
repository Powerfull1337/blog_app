import 'package:intl/intl.dart';

String formattedByDMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}

String formattedByMMMYYYY(DateTime dateTime) {
  return DateFormat(" MMM , yyyy").format(dateTime);
}
