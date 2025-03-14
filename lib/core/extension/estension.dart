import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

extension GetSize on double {
  double h(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }

  double w(BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }

  double toRes(BuildContext context) {
    return (getSize(context).height * this) + (getSize(context).width * this);
  }
}

extension Capitalize on String {
  String? capitalize() {
    if (isEmpty) {
      return null;
    }
    return this[0].toUpperCase() + (length > 1 ? substring(1) : '');
  }
}

extension DateTimeFormat on DateTime {
  String toCustomFormat() {
    return DateFormat('yyyy/MM/dd').format(this);
  }
}
