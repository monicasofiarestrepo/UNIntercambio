class ExchangeRate {
  final String baseCode;
  final Map<String, num> conversionRates;

  ExchangeRate({
    required this.baseCode,
    required this.conversionRates,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      baseCode: json['base_code'],
      conversionRates: Map<String, num>.from(json['conversion_rates']),
    );
  }
}
