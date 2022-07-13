import 'package:flutter/material.dart';
import 'package:macprojet/screens/market/components/detail_market_news.dart';
import 'package:macprojet/screens/market/components/top_container.dart';
import 'package:macprojet/screens/market/model/market_model.dart';
import 'package:macprojet/screens/market/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class MyFavoriteList extends StatefulWidget {
  @override
  _MyFavoriteListState createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
    ApiService client = ApiService();

  List<Market> _favoriteMarket = [];
  bool _favorisItems = false;
  List marketIdFavorite = [];
  void initState() {
    // navigateUser();
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer(Duration(milliseconds: 1500), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var favoriteMarket = localStorage.getString('favoriteMarketId');
    var testing = jsonDecode(favoriteMarket ?? '');
    print('checking the value of favoriteMarket ${testing[0]}');
    if (favoriteMarket != null) {
      setState(() {
        _favorisItems = true;
        marketIdFavorite = testing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay marketOpen = TimeOfDay(hour: 9, minute: 0);
    TimeOfDay marketClose = TimeOfDay(hour: 14, minute: 0);
        double _doubleNowTime = now.hour.toDouble() + (now.minute.toDouble() / 60);


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
      return Scaffold(
      body: FutureBuilder(
        future: client.getMarketData(),
        builder: (BuildContext context, AsyncSnapshot<List<Market>> snapshot) {
          if (snapshot.hasData) {
           List<Market> marketData = snapshot.data!.where((map)=>marketIdFavorite.contains(map.codeISIN)).toList();
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;

            return (ListView(
              children: [
                if (_doubleNowTime > 9 && _doubleNowTime < 13.9)
                  ...[
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
                  ]
                else ...[
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
                      children: marketData
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
                                name:marketData.name,
                                codeISIN: marketData.codeISIN,
                                groupe: marketData.groupe,
                                price: marketData.prixVeille,
                                codeMN: marketData.codeMN,
                                date: marketData.heure,
                                market: marketData,
                                marketIdFavorite: marketIdFavorite,
                                context :context,

                              ))
                          .toList(),
                    )
                  ],
                ),
              ],
            ));
            
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
    {height, width, codeISIN, groupe, price, date, codeMN,name ,market,List? marketIdFavorite ,context,onPress}) {
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
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 20.0,
                  color: Color.fromARGB(255, 255, 42, 5),
                ),
                onPressed: () {
                  deleteFavoris(codeISIN ,marketIdFavorite, context);
                  // login(market);
                },
              ),
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
  );
}
Future<dynamic> deleteFavoris(String marketId, List? marketIdFavorite, context) async {
  print('checking the marketId $marketId checking the marketObject $marketIdFavorite ');
  final existingIndex =
        marketIdFavorite!.indexWhere((favorite) => favorite == marketId);
        print('checking the existingIndex $existingIndex');
        if (existingIndex >= 0) {
      marketIdFavorite.removeAt(existingIndex);
    } 
  print('checking the marketIdFavorite what $marketIdFavorite');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // marketIdFavorite.add(market.codeISIN);
  sharedPreferences.setString("favoriteMarketId", jsonEncode(marketIdFavorite));
  print('checking the idsss $marketIdFavorite');
  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyFavoriteList()),
                                  );
}