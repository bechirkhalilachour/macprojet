import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macprojet/screens/market/components/detail_chip.dart';
import 'package:macprojet/screens/market/model/market_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarketDetail extends StatelessWidget {
  static const routeName = '/market-detail';

  const MarketDetail({
    required this.newsDetail,
    Key? key,
  }) : super(key: key);
  final Market newsDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF9EC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '#${newsDetail.name}',
          style: const TextStyle(
              color: Color(0xFF606060), fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        /* 
        child: Text(
            "ACCOUNT SETTING",
            style: TextStyle(
                fontSize: 23,
                color: Color(0xFF606060),
                fontWeight: FontWeight.bold),
          ),
         */
        backgroundColor: Color(0xFFFFF9EC),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 120,
                  child: Card(
                    color: Color(0xFFFFF9EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // child: Image.network(
                            //   "https://image.freepik.com/vecteurs-libre/marathon_52683-9132.jpg",
                            //   fit: BoxFit.cover,
                            // ),
                            child: SvgPicture.asset(
                              "assets/icons/trade.svg",
                              height: 100,
                              // fit: BoxFit.cover,
                              // height: size.height * 0.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prix Veille: ${newsDetail.prixVeille} TND',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    // TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     textStyle: const TextStyle(fontSize: 20),
                    //   ),
                    //   icon: Icon(Icons.favorite),
                    //   label:Text('Add to Favoris'),
                    //   onPressed: () {
                    //     print('hello');
                    //   },
                    // ),                   
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
            ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: DetailChip(
                            iconData: FontAwesomeIcons.objectGroup,
                            title: "Groupe",
                            data: newsDetail.groupe,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: DetailChip(
                            iconData: FontAwesomeIcons.centercode,
                            title: "Code MN",
                            data: newsDetail.codeMN,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: DetailChip(
                              iconData: FontAwesomeIcons.timeline,
                              title: "Date",
                              data: newsDetail.heure,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.star ),
      //   onPressed: () => {},
      // ),
    );
  }
}

SizedBox orangeDivider() {
  return const SizedBox(
    width: 90,
    child: Divider(
      thickness: 4,
      color: Color(0xFFFF5D55),
    ),
  );
}
