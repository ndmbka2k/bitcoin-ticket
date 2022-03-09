import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> coinPrices = {};
  bool isWaiting = false;
  void getRate() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinPrices = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  List<Card> cards() {
    List<Card> temp = [];
    for (String coin in cryptoList) {
      var newCard = Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = ${isWaiting ? '?' : coinPrices[coin]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      temp.add(newCard);
    }
    return temp;
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                  getRate();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class CoinCard extends StatelessWidget {
//   final coin;
//   final selectedCurrency;
//   final price;

//   CoinCard({this.coin, this.price, this.selectedCurrency});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.lightBlueAccent,
//       elevation: 5.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//         child: Text(
//           '1 $coin = $price $selectedCurrency',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
