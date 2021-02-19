import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

class Notification {
  Notification(
      {@required this.title, @required this.description, @required this.read});

  final String title;
  final String description;
  bool read;
}

class NotificationService {
  NotificationService(Config config);

  Future<List<Notification>> loadNotifications() async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
        40,
        (index) => Notification(
              title: 'Title $index',
              description: 'Description $index',
              read: Random().nextBool(),
            ));
  }
}

// This class should not be exported by this package. If another package
// needs access to a subset of information in this package that should be
// handled via the shared NotificationModel
class InternalNotificationModel extends ChangeNotifier {
  InternalNotificationModel(this.service);

  final NotificationService service;
  AsyncSnapshot<List<Notification>> notifications = AsyncSnapshot.nothing();

  Future<void> loadNotifications() async {
    if (notifications.hasData) {
      return;
    }

    notifications = notifications.inState(ConnectionState.waiting);
    notifyListeners();
    try {
      notifications = AsyncSnapshot.withData(
          ConnectionState.done, await service.loadNotifications());
    } catch (e) {
      notifications = AsyncSnapshot.withError(ConnectionState.done, e);
    } finally {
      notifyListeners();
    }
  }

  void markAsRead(int index) {
    assert(notifications.hasData);
    notifications.data[index].read = true;
    notifyListeners();
  }
}
