class UrlConstant {
  UrlConstant._();

  static const String baseUrl = 'https://lms.bgyn.live/api/v1';
  // static const String baseUrl = 'http://192.168.1.214:3000/api/v1';

  static const String mediaUrl = 'https://lms.bgyn.live';
  // static const String mediaUrl = 'http://192.168.1.214:3000';

  static String login() {
    return '$baseUrl/auth/login';
  }

  static String register() {
    return '$baseUrl/auth/register';
  }

  static String verifyToken() {
    return '$baseUrl/auth/verify';
  }

  static String refreshToken() {
    return '$baseUrl/auth/refresh';
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

  static String video(String path, String courseId) {
    return '$baseUrl/video?courseId=$courseId&path=$path';
  }

  static String createPaymentIntent() {
    return '$baseUrl/payment/create-payment-intent';
  }

  static String myEnrollment() {
    return '$baseUrl/enrollment';
  }

  static String notifcation() {
    return '$baseUrl/notification';
  }

  static String markAllAsRead() {
    return '$baseUrl/notification/read';
  }

  static String markAsRead(String id) {
    return '$baseUrl/notification/read?id=$id';
  }
}
