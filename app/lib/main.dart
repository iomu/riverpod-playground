import 'package:contacts/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifications/notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

Future<void> main() async {
  // runApp(ProviderApp(
  //   config: await loadConfig(),
  // ));
  runApp(
    RiverpodApp(
      config: await loadConfig(),
    ),
  );
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

class RiverpodApp extends StatelessWidget {
  const RiverpodApp({Key key, this.config}) : super(key: key);

  final Config config;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        ...notificationOverrides,
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        routes: {
          Routes.contacts: (context) => RiverpodContactsScreen(),
          Routes.notifications: (context) => RiverpodNotificationScreen(),
        },
        initialRoute: Routes.contacts,
      ),
    );
  }
}
