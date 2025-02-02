class UrlConstant {
  UrlConstant._();

  static const String baseUrl = 'https://lms.bgyn.live/api/v1';
  static const String mediaUrl = 'https://lms.bgyn.live';

  static String login() {
    return '$baseUrl/auth/login';
  }

  static String register() {
    return '$baseUrl/auth/register';
  }

  static String verifyOtp() {
    return '$baseUrl/auth/verify-otp';
  }

  static String passwordReset() {
    return '$baseUrl/auth/reset-password';
  }

  static String passwordResetRequest() {
    return '$baseUrl/auth/forgot-password';
  }

  static String profile() {
    return '$baseUrl/profile';
  }

  static String allCourse() {
    return '$baseUrl/course/all';
  }

  static String courseById(String id) {
    return '$baseUrl/course/$id';
  }

  static String video(String path) {
    return '$baseUrl/video?path=$path';
  }

  static String createPaymentIntent() {
    return '$baseUrl/payment/create-payment-intent';
  }
}
