class Config {
  Config(this.apiUrl);

  final String apiUrl;
}

Future<Config> loadConfig() async => Config("https://example.com");
