import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String sender;
  final String message;
  final String time;
  final String type; // 'teacher', 'department', 'schedule', 'event'
  final IconData icon;
  bool isUnread;

  NotificationModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
    required this.type,
    required this.icon,
    this.isUnread = true,
  });
}
