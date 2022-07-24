import 'package:flutter/material.dart';
import 'package:macprojet/enums.dart';
import 'package:macprojet/screens/favoris/favoris_screen.dart';

import '../../components/coustom_bottom_nav_bar.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({ Key? key }) : super(key: key);
    static String routeName = "/favoris_list";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: MyFavoriteList(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),

    );
  }
}