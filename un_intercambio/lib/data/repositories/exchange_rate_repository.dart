import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:un_intercambio/data/models/exchage_rate.dart';

class ExchangeRateRepository {
  final String _apiKey = 'd6c7e6e27762637c3ce59915';
  final String _baseUrl = 'https://v6.exchangerate-api.com/v6/';

  Future<ExchangeRate> fetchExchangeRates(String baseCurrency) async {
    final response = await http.get(Uri.parse('$_baseUrl$_apiKey/latest/$baseCurrency'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["result"] == "success") {
        return ExchangeRate.fromJson(data);
      } else {
        throw Exception('Código de moneda desconocido');
      }
    } else {
      throw Exception('Error al obtener tasas de cambio');
    }
  }
}
