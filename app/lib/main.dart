import 'package:contacts/contacts.dart';
import 'package:flutter/material.dart';
import 'package:notifications/notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

Future<void> main() async {
  runApp(ProviderApp(
    config: await loadConfig(),
  ));
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key key, this.config}) : super(key: key);

  final Config config;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        NotificationProvider(config),
        ContactProvider(config),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        routes: {
          Routes.notifications: (context) => ProviderNotificationScreen(),
          Routes.contacts: (context) => ProviderContactsScreen(),
        },
        initialRoute: Routes.contacts,
      ),
    );
  }
}
