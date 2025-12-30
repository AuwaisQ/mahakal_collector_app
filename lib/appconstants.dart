
class AppConstants {
  static const String appName = 'Mahakal.com';
  static const String slogan = 'E-Commerce Marketplace';
  static const String appVersion = '1.1';

  // static const String baseUrl = 'https://uat.pavtr.in';
  static const String baseUrl = 'https://sit.resrv.in';
  // static const String baseUrl = 'https://mahakal.com';

  static const String apiVersion = "/api/v1";

 // Razorpay API key
  static const razorpayLive =
  (baseUrl == 'https://uat.pavtr.in' || baseUrl == 'https://sit.resrv.in')
      ? 'rzp_test_vsSpBCHRz9XUp2' // UAT & SIT → Test key
      : 'rzp_live_InwZruBPIWObnO'; // Others (like prod) → Live key

  /// Mahakal Collector
  static const loginAPI = "$apiVersion/collector/login";
  static const logoutAPI = "$apiVersion/collector/logout";
  static const collectorDashboardAPI = "$apiVersion/collector/dashboard";
  static const collectorDetailsAPI = "$apiVersion/collector/temple/detail?temple_id=";
  static const collectorSDMListAPI = "$apiVersion/collector/collector-sdm-list";
  static const collectorTempleListAPI = "$apiVersion/collector/sdm-temple-list";
  static const collectorAmountFilterAPI = "$apiVersion/collector/datewise/amount?";


  /// SDM API
  static const sdmDashboardAPI = "$apiVersion/sdm/dashboard";
  static const sdmDetailsAPI = "$apiVersion/sdm/temple/detail?temple_id=";
  static const sdmEmployeeListAPI = "$apiVersion/sdm/sdm-employee-list";
  static const sdmAmountFilterAPI = "$apiVersion/sdm/datewise/amount?";


}


class Images{
  static const String appLogo = 'assets/images/mahakal.jpeg';
}