import 'package:contacts/src/model.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

class ContactProvider extends MultiProvider {
  ContactProvider(Config config)
      : super(providers: [
          ChangeNotifierProvider(
            create: (_) => InternalContactModel(ContactService(config)),
          ),
        ]);
}
