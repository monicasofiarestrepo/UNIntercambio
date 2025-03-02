import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({super.key});

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  String? selectedCurrency = "USD";

  final List<Map<String, String>> currencies = [
    {"code": "USD", "name": "Dólar estadounidense", "flag": "🇺🇸"},
    {"code": "EUR", "name": "Euro", "flag": "🇪🇺"},
    {"code": "GBP", "name": "Libra esterlina", "flag": "🇬🇧"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: SystemColors.neutralDark, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonFormField<String>(
        value: selectedCurrency,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        icon: const Icon(Icons.arrow_drop_down),
        items: currencies.map((currency) {
          return DropdownMenuItem<String>(
            value: currency["code"],
            child: Row(
              children: [
                Text(currency["flag"]!, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text("${currency["code"]} - ${currency["name"]}"),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        },
      ),
    );
  }
}