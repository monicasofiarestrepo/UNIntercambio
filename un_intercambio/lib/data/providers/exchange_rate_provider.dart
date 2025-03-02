import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/models/exchage_rate.dart';
import 'package:un_intercambio/data/repositories/exchange_rate_repository.dart';

// Proveedor del repositorio
final exchangeRateRepositoryProvider = Provider((ref) {
  return ExchangeRateRepository();
});

// Proveedor de tasas de cambio con una moneda base variable
final exchangeRateProvider = FutureProvider.family<ExchangeRate, String>((ref, baseCurrency) async {
  final repository = ref.watch(exchangeRateRepositoryProvider);
  return repository.fetchExchangeRates(baseCurrency);
});
