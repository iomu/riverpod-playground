import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationModel {
  NotificationModel({
    @required this.unreadCount,
    @required this.loadNotifications,
  });

  final int unreadCount;
  final Future<void> Function() loadNotifications;
}

// TODO compute this based on the internal notification model
final notificationProvider = ScopedProvider<NotificationModel>(
    (_) => NotificationModel(unreadCount: 0, loadNotifications: () async {}));
