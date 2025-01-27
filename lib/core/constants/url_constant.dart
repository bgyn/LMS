class UrlConstant {
  UrlConstant._();

  static const String baseUrl = 'http://192.168.1.214:3000/api/v1';

  static String login() {
    return '$baseUrl/auth/login';
  }

  static String register() {
    return '$baseUrl/auth/register';
  }
}
