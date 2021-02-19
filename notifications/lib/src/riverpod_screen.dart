import 'package:notifications/src/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodNotificationScreen extends StatefulWidget {
  @override
  _RiverpodNotificationScreenState createState() =>
      _RiverpodNotificationScreenState();
}

class _RiverpodNotificationScreenState
    extends State<RiverpodNotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read(notificationsProvider).loadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          // NotificationBadge(),
        ],
      ),
      body: Consumer(
        builder: (context, watch, _) => Builder(
          builder: (context) {
            final notificationModel = watch(notificationsProvider);
            final notifications = notificationModel.notifications;
            if (notifications.hasError) {
              return Center(child: Text(notifications.error.toString()));
            }

            if (!notifications.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: notifications.data.length,
              itemBuilder: (context, index) {
                final notification = notifications.data[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.description),
                  trailing: notification.read
                      ? null
                      : Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.red,
                        ),
                  onTap: () => notificationModel.markAsRead(index),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
