import 'package:flutter/material.dart';

extension ListExtension on List<Widget> {
  List<Widget> addSpacer(
    Widget spacer, {
    bool includeStart = false,
    bool includeEnd = false,
  }) {
    List<Widget> spacedList = [];

    if (isEmpty) return spacedList;

    if (includeStart) {
      spacedList.add(spacer);
    }

    for (int i = 0; i < length; i++) {
      spacedList.add(this[i]);
      if (i < length - 1) {
        spacedList.add(spacer);
      }
    }

    if (includeEnd) {
      spacedList.add(spacer);
    }

    return spacedList;
  }
}
