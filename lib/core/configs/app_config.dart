// Removed dart:io import for web compatibility

enum Environment { development, staging, production }

class AppConfig {
  static Environment get flavor => Environment.values.firstWhere(
    (e) => e.name == const String.fromEnvironment('FLAVOR'),
    orElse: () => Environment.development,
  );


  static String get googleAuthClintId =>
      const String.fromEnvironment('GOOGLE_AUTH_CLINT_ID');

  static String get baseUrl => const String.fromEnvironment('BASE_URL');
  static String get mexcUrl => const String.fromEnvironment('MEXC_API');
  static String get imageUrl => const String.fromEnvironment('IMAGE_URL');
  static String get socketIoUrl =>
      const String.fromEnvironment('SOCKET_IO_URL');
  static String get baseUrlIOS => const String.fromEnvironment('BASE_URL_IOS');


  static String get webURL => const String.fromEnvironment('WEB_URL');
  static String get privacyUrl => "$webURL/privacy-policy";
 
  @override
  String toString() {
    return '''

      flavor: ${flavor.name}
      baseUrl: $baseUrl
      baseUrlIOS: $baseUrlIOS
      webUrl: $webURL

      socketIoUrl:$socketIoUrl
      s3 bucketurl:$imageUrl
      
    ''';
  }
}
