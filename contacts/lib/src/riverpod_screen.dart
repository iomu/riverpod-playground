import 'package:contacts/src/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

class RiverpodContactsScreen extends StatefulWidget {
  @override
  _RiverpodContactsScreenState createState() => _RiverpodContactsScreenState();
}

class _RiverpodContactsScreenState extends State<RiverpodContactsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read(contactsProvider).loadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          _NotificationBadge(),
        ],
      ),
      body: Consumer(
        builder: (context, watch, _) => Builder(
          builder: (context) {
            final contacts = watch(contactsProvider).contacts;
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
      ),
    );
  }
}

class _NotificationBadge extends StatefulWidget {
  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<_NotificationBadge> {
  @override
  Widget build(BuildContext context) {
    const double bubbleSize = 15;
    return IconButton(
      icon: Consumer(
        builder: (context, watch, _) {
          final unread = watch(notificationProvider).unreadCount;
          return Stack(
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
          );
        },
      ),
      onPressed: () => Navigator.pushNamed(context, Routes.notifications),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read(notificationProvider).loadNotifications());
  }
}
