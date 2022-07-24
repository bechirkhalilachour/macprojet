import 'package:flutter/material.dart';
import 'package:macprojet/screens/market/components/detail_market_news.dart';
import 'package:macprojet/screens/market/components/top_container.dart';
import 'package:macprojet/screens/market/model/market_model.dart';
import '../services/api_service.dart';
// import '../components/customListTile.dart';
import '../model/market_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List marketIdFavorite = [];

  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var favoriteMarket = localStorage.getString('favoriteMarketId');
    var testing = jsonDecode(favoriteMarket ?? '');
    print('checking the value of favoriteMarket ${testing[0]}');
    if (favoriteMarket != null) {
      setState(() {
        marketIdFavorite = testing;
      });
    }
  }

  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay marketOpen = TimeOfDay(hour: 9, minute: 0);
    TimeOfDay marketClose = TimeOfDay(hour: 14, minute: 0);
    //  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0 ;
    double _doubleOpenTime =
        marketOpen.hour.toDouble() + (marketOpen.minute.toDouble() / 60);
    double _doubleCloseTime =
        marketClose.hour.toDouble() + (marketClose.minute.toDouble() / 60);
    double _doubleNowTime = now.hour.toDouble() + (now.minute.toDouble() / 60);
    List<Market> _favoriteMarket = [];

    // print()
    return Scaffold(
      //Now let's call the APi services with futurebuilder wiget
      body: FutureBuilder(
        future: client.getMarketData(),
        builder: (BuildContext context, AsyncSnapshot<List<Market>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<Market>? marketData = snapshot.data;
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return (ListView(
              children: [
                if (_doubleNowTime > 9 && _doubleNowTime < 13.9) ...[
                  TopContainer(
                    color: Color.fromARGB(255, 0, 255, 13),
                    height: 50,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Text('Ouvert',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[],
                          ),
                        )
                      ],
                    ),
                  ),
                ] else ...[
                  TopContainer(
                    color: Colors.red,
                    height: 50,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Text('fermé',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                Column(
                  children: [
                    Column(
                      children: marketData!
                          .map((Market marketData) => marketNewsContainer(
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarketDetail(
                                            newsDetail: marketData)),
                                  );
                                },
                                height: height,
                                width: width,
                                name: marketData.name,
                                codeISIN: marketData.codeISIN,
                                groupe: marketData.groupe,
                                price: marketData.prixVeille,
                                codeMN: marketData.codeMN,
                                date: marketData.heure,
                                market: marketData,
                                marketIdFavorite: marketIdFavorite,
                              ))
                          .toList(),
                    )
                    // lehna
                  ],
                ),
              ],
            ));
            // return ListView.builder(
            //   //Now let's create our custom List tile
            //   itemCount: articles!.length,
            //   itemBuilder: (context, index) =>
            //       customListTile(articles[index], context),
            // );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget marketNewsContainer(
    {height,
    width,
    codeISIN,
    groupe,
    price,
    date,
    codeMN,
    market,
    name,
    List? marketIdFavorite,
    onPress}) {
  var isFavoritOne = marketIdFavorite!.contains(market.codeISIN);
  return GestureDetector(
    onTap: onPress,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(3.0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 244, 242, 242),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      height: height * 0.20,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Name $name',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                if (isFavoritOne) ...[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 20.0,
                      color: Color.fromARGB(255, 255, 42, 5),
                    ),
                    onPressed: () {
                      addFavorite(market, marketIdFavorite);
                    },
                  ),
                ] else ...[
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20.0,
                      color: Color.fromARGB(255, 255, 42, 5),
                    ),
                    onPressed: () {
                      addFavorite(market, marketIdFavorite);
                    },
                  ),
                ],
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "CodeMN $codeMN",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Groupe $groupe ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '$date',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "$price TND",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ])
            ],
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> addFavorite(Market market, List marketIdFavorite) async {
  print('checking the marketIdFavorite what $marketIdFavorite');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  marketIdFavorite.add(market.codeISIN);
  sharedPreferences.setString("favoriteMarketId", jsonEncode(marketIdFavorite));
  print('checking the idsss $marketIdFavorite');
}
