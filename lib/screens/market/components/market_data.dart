import 'package:flutter/material.dart';
import 'package:macprojet/components/coustom_bottom_nav_bar.dart';
import 'package:macprojet/enums.dart';
import 'package:macprojet/screens/market/components/body.dart';


class MarketData extends StatelessWidget {
  static String routeName = "/market_data";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.news),

    );
  }
}
