import 'package:flutter/foundation.dart';

class NotificationModel {
  NotificationModel({
    @required this.unreadCount,
    @required this.loadNotifications,
  });

  final int unreadCount;
  final Future<void> Function() loadNotifications;
}
