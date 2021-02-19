import 'package:contacts/src/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

final contactsProvider = ChangeNotifierProvider<InternalContactModel>((ref) {
  // TODO: when configProvider is a future provider we have to handle the async
  // nature of the result here
  final config = ref.watch(configProvider);
  return InternalContactModel(ContactService(config.state));
});
