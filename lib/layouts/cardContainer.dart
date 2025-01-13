import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/card.dart';

// ignore: use_key_in_widget_constructors
class CardContainer extends StatelessWidget {
  final List<Map<String, dynamic>> currencyData = [
    {
      'name': 'Euro',
      'code': 'EUR',
      'amount': '6 428',
      'icon': Icons.euro_rounded,
    },
    {
      'name': 'Dollar',
      'code': 'USD',
      'amount': '55 622',
      'icon': Icons.attach_money_rounded,
    },
    {
      'name': 'Bitcoin',
      'code': 'BTC',
      'amount': '7 928',
      'icon': Icons.currency_bitcoin_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < currencyData.length; i++)
          CurrencyCard(
            name: currencyData[i]['name'],
            code: currencyData[i]['code'],
            amount: currencyData[i]['amount'],
            icon: currencyData[i]['icon'],
            isInverted: i % 2 != 0 || false,
            y: i * -20,
          ),
      ],
    );
  }
}
