import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/providers/exchange_rate_provider.dart';
import 'package:country_flags/country_flags.dart';

class CurrencyConverterScreen extends ConsumerStatefulWidget {
  const CurrencyConverterScreen({super.key});
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends ConsumerState<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String selectedCurrency = "USD";
  double convertedAmount = 0.0;

  final List<Map<String, String>> currencies = [
    {"code": "USD", "flag": "US"},
    {"code": "EUR", "flag": "ES"},
    {"code": "GBP", "flag": "GB"},
    {"code": "JPY", "flag": "JP"},
    {"code": "BRL", "flag": "BR"},
  ];

  void convertCurrency(double rate) {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      convertedAmount = amount * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exchangeRates = ref.watch(exchangeRateProvider("COP"));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertidor de Moneda"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Monto en COP",
                      border: OutlineInputBorder(),
                    ),
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
                            CountryFlag.fromCountryCode(currency["flag"]!, height: 20, width: 30),
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
                      final num rate = data.conversionRates[selectedCurrency] ?? 1;
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => convertCurrency(rate.toDouble()),
                            child: const Text("Convertir"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Total: ${convertedAmount.toStringAsFixed(2)} $selectedCurrency",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => const Text("Error al cargar tasas"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
