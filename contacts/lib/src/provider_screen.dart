import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:contacts/src/model.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

class ProviderContactsScreen extends StatefulWidget {
  @override
  _ProviderContactsScreenState createState() => _ProviderContactsScreenState();
}

class _ProviderContactsScreenState extends State<ProviderContactsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<InternalContactModel>().loadContacts());
  }

  @override
  Widget build(BuildContext context) {
    final contacts = context.watch<InternalContactModel>().contacts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          NotificationBadge(),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (contacts.hasError) {
            return Center(child: Text(contacts.error.toString()));
          }

          if (!contacts.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: contacts.data.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(contacts.data[index].name),
            ),
          );
        },
      ),
    );
  }
}

class NotificationBadge extends StatefulWidget {
  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  Widget build(BuildContext context) {
    const double bubbleSize = 15;
    final unread =
        context.select<NotificationModel, int>((value) => value.unreadCount);
    return IconButton(
      icon: Stack(
        children: <Widget>[
          Icon(unread > 0 ? Icons.notifications : Icons.notifications_none),
          if (unread > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                constraints: const BoxConstraints(
                    maxHeight: bubbleSize,
                    minWidth: bubbleSize,
                    minHeight: bubbleSize),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(bubbleSize / 2),
                ),
                child: Center(
                  child: Text(
                    '$unread',
                    softWrap: false,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            )
        ],
      ),
      onPressed: () => Navigator.pushNamed(context, Routes.notifications),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NotificationModel>().loadNotifications());
  }
}
