class Urls {
  static const String baseUrl  = 'https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout';

  static const String grantTokenUrl = '$baseUrl/token/grant';
  static const String createPaymentUrl = '$baseUrl/payment/create';
  static const String executePaymentUrl = '$baseUrl/execute';
}