
class AppConstants {
  static const String appName = 'Mahakal.com';
  static const String slogan = 'E-Commerce Marketplace';
  static const String appVersion = '1.1';

  // static const String baseUrl = 'https://uat.pavtr.in';
  static const String baseUrl = 'https://sit.resrv.in';
  // static const String baseUrl = 'https://mahakal.com';

// Razorpay API key
  static const razorpayLive =
  (baseUrl == 'https://uat.pavtr.in' || baseUrl == 'https://sit.resrv.in')
      ? 'rzp_test_vsSpBCHRz9XUp2' // UAT & SIT → Test key
      : 'rzp_live_InwZruBPIWObnO'; // Others (like prod) → Live key

}


class Images{
  static const String appLogo = 'assets/images/mahakal.jpeg';
}