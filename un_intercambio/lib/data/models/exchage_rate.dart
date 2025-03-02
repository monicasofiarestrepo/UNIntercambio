class ExchangeRate {
  final String baseCode;
  final Map<String, double> conversionRates;

  ExchangeRate({
    required this.baseCode,
    required this.conversionRates,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      baseCode: json['base_code'],
      conversionRates: Map<String, double>.from(json['conversion_rates']),
    );
  }
}
