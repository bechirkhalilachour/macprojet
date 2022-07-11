import 'dart:convert';

import '../model/market_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';

//Now let's make the HTTP request services
// this class will alows us to make a simple get http request
// from the API and get the Articles and then return a list of Articles

class ApiService {
  //let's add an Endpoint URL, you can check the website documentation
  // and learn about the different Endpoint
  //for this example I'm going to use a single endpoint

  //NOTE: make sure to use your OWN apikey, you can make a free acount and
  // choose a developer option it's FREE
  final endPointUrl =
      "http://etradetest.macsa.com.tn:10221/MDG/Intraday/GetIntraday/";
  //"http://newsapi.org/v2/top-headlines?country=fr&category=sport&apiKey=f8e1f2de74da46e3ae4d6866c1e997b8";

  //Now let's create the http request function
  // but first let's import the http package

  Future<List<Market>> getMarketData() async {
    Response res = await get(Uri.parse(endPointUrl));

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (res.statusCode == 200) {

      List<dynamic> body = jsonDecode(res.body);
      List<Market> marketData = body
          .map(
            (dynamic item) => Market.fromJson(item),
          )
          .toList();
      return marketData;
    } else {
      throw ("Can't get the marketData");
    }
  }
}
