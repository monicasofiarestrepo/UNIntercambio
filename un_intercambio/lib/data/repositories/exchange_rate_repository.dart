import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:un_intercambio/data/models/exchage_rate.dart';

class ExchangeRateRepository {
  final String _baseUrl =
      'https://v6.exchangerate-api.com/v6/d6c7e6e27762637c3ce59915/latest/USD';

  Future<ExchangeRate> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ExchangeRate.fromJson(data);
    } else {
      throw Exception('Error al obtener tasas de cambio');
    }
  }
}
