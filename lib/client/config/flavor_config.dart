enum Flavor { admin, client }

class FlavorConfig {
  final Flavor flavor;
  final String name;

  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
  }) {
    _instance = FlavorConfig._internal(flavor, name);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name);

  static FlavorConfig get instance => _instance;
  static bool isAdmin() => _instance.flavor == Flavor.admin;
  static bool isClient() => _instance.flavor == Flavor.client;
}
