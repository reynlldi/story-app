import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDateTime(String? rawDateTime, Locale locale) {
  if (rawDateTime == null) {
    return "";
  }

  final dateTime = DateTime.parse(rawDateTime);
  final format = DateFormat('dd MMMM yyyy, HH:mm:ss', locale.languageCode);
  final formattedDate = format.format(dateTime);

  return formattedDate;
}
