import 'package:flutter_riverpod/flutter_riverpod.dart';

class Config {
  Config(this.apiUrl);

  final String apiUrl;
}

Future<Config> loadConfig() async => Config("https://example.com");

// TODO: how to initialize this? Could use a FutureProvider but then
// we have issues creating the ChangeNotifierProvider later on
final configProvider = StateProvider<Config>((_) => null);
