import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:un_intercambio/data/models/exchage_rate.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: "https://v6.exchangerate-api.com/v6/d6c7e6e27762637c3ce59915/latest/"));
});

final exchangeRateProvider = FutureProvider.family<ExchangeRate, String>((ref, baseCurrency) async {
  final dio = ref.watch(dioProvider);
  try {
    final response = await dio.get(baseCurrency);
    return ExchangeRate.fromJson(response.data);
  } catch (e) {
    throw Exception("Failed to fetch exchange rates: $e");
  }
});
