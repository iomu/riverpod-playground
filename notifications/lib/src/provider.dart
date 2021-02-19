import 'package:notifications/src/model.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

// here we define how the internal model is mapped to the shared model and
// create all providers needed for this package to be used
class NotificationProvider extends MultiProvider {
  NotificationProvider(Config config)
      : super(providers: [
          ChangeNotifierProvider(
            create: (_) =>
                InternalNotificationModel(NotificationService(config)),
          ),
          ProxyProvider<InternalNotificationModel, NotificationModel>(
            update: (context, model, _) => NotificationModel(
              unreadCount:
                  (model.notifications.data ?? []).where((n) => !n.read).length,
              loadNotifications: model.loadNotifications,
            ),
          )
        ]);
}
