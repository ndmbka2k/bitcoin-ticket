import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> coinPrices = {};
    for (String coin in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=73930C8F-9936-4B91-9C3E-9011D8FA2564'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double price = data['rate'];
        coinPrices[coin] = price.toStringAsFixed(2);
      } else {
        print(response.statusCode);
      }
    }
    return coinPrices;
  }
}
