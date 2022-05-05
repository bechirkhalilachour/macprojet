import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../components/customListTile.dart';
import '../model/article_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Now let's call the APi services with futurebuilder wiget
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<Article>? articles = snapshot.data;
            return ListView.builder(
              //Now let's create our custom List tile
              itemCount: articles!.length,
              itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
