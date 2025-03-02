import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/data/providers/exchange_rate_provider.dart';
import 'package:country_flags/country_flags.dart';

class CurrencyConverterScreen extends ConsumerStatefulWidget {
  const CurrencyConverterScreen({super.key});
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState
    extends ConsumerState<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String selectedCurrency = "USD";
  String confirmedCurrency = "USD";
  double convertedAmount = 0.0;
  double lastUsedRate = 1.0; // Guarda la última tasa de conversión utilizada

  final List<Map<String, String>> currencies = [
    {"code": "USD", "flag": "US"},
    {"code": "EUR", "flag": "ES"},
    {"code": "GBP", "flag": "GB"},
    {"code": "JPY", "flag": "JP"},
    {"code": "BRL", "flag": "BR"},
  ];

  void convertCurrency() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      convertedAmount = amount * lastUsedRate;
      confirmedCurrency = selectedCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exchangeRates = ref.watch(exchangeRateProvider("COP"));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Convertidor de divisas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Aquí podrás ver el equivalente de dinero colombiano en las principales monedas del mundo.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Monto en COP",
                          prefixText: "\$ ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Texto que indica a qué moneda se está convirtiendo
                      Text(
                        "a : ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      DropdownButton<String>(
                        value: selectedCurrency,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCurrency = newValue!;
                          });
                        },
                        items: currencies.map((currency) {
                          return DropdownMenuItem<String>(
                            value: currency["code"],
                            child: Row(
                              children: [
                                CountryFlag.fromCountryCode(
                                    currency["flag"]!,
                                    height: 20,
                                    width: 30),
                                const SizedBox(width: 10),
                                Text(currency["code"]!),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      exchangeRates.when(
                        data: (data) {
                          lastUsedRate =
                              (data.conversionRates[selectedCurrency] ?? 1)
                                  .toDouble();

                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: convertCurrency,
                                child: const Text("Convertir"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: SystemColors.primaryPrink,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Total: ${convertedAmount.toStringAsFixed(2)} $confirmedCurrency",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (err, stack) =>
                            const Text("Error al cargar tasas"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
