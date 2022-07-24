import 'package:flutter/material.dart';
import 'package:macprojet/models/current_user.dart';
import 'package:macprojet/screens/home/components/chart.dart';
import 'package:macprojet/screens/home/components/chart2.dart';
import 'package:macprojet/screens/home/components/chart3.dart';
import 'package:macprojet/screens/home/components/chart4.dart';

import '../../../size_config.dart';

import 'home_header.dart';

import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                CurrentUser.email!,
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/drawer.jpg'),
                ),
              ),
            ),
            ListTile(
              title: Text("Item"),
              onTap: () {
                print("item pressed");
              },
            ),
            ListTile(
              title: Text("Item"),
              onTap: () {
                print("item pressed");
              },
            ),
            ListTile(
              title: Text("Item"),
              onTap: () {
                print("item pressed");
              },
            ),
            ListTile(
              title: Text("Item"),
              onTap: () {
                print("item pressed");
              },
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(10)),
              // SpecialOffers(),
              LineChartSample1(),
              LineChartSample2(),
              // LineChartSample7(),
              PieChartSample1(),
            ],
          ),
        ),
      ),
    );
  }
}
