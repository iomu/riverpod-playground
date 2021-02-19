import 'package:notifications/src/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

final notificationsProvider =
    ChangeNotifierProvider<InternalNotificationModel>((ref) {
  // TODO: when configProvider is a future provider we have to handle the async
  // nature of the result here
  final config = ref.watch(configProvider);
  return InternalNotificationModel(NotificationService(config.state));
});