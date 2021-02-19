import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notifications/src/model.dart';
import 'package:provider/provider.dart';

class ProviderNotificationScreen extends StatefulWidget {
  @override
  _ProviderNotificationScreenState createState() =>
      _ProviderNotificationScreenState();
}

class _ProviderNotificationScreenState
    extends State<ProviderNotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<InternalNotificationModel>().loadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    final notificationModel = context.watch<InternalNotificationModel>();
    final notifications = notificationModel.notifications;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Builder(
        builder: (context) {
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
    );
  }
}
