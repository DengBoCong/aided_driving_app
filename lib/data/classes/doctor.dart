import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Doctor {
  Doctor(
    this.index,
    this.title,
    this.subtitle,
    this.color,
  );

  final int index;
  final String title;
  final String subtitle;
  final Color color;
}