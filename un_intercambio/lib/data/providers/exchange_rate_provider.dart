import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/repositories/exchange_rate_repository.dart';
import 'package:un_intercambio/data/models/exchage_rate.dart';

final exchangeRateRepositoryProvider = Provider((ref) {
  return ExchangeRateRepository();
});

final exchangeRateProvider = FutureProvider<ExchangeRate>((ref) async {
  final repository = ref.watch(exchangeRateRepositoryProvider);
  return repository.fetchExchangeRates();
});
