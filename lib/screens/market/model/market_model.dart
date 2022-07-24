//Now let's create the market model
// for that we just need to copy the property from the json structure
// and make a dart object


class Market {
  String codeISIN;
  String codeMN;
  String groupe;
  String heure;
  String name;
  String prixVeille;
  
  //Now let's create the constructor
  Market(
      {
      required this.codeISIN,
      required this.codeMN,
      required this.groupe,
      required this.heure,
      required this.name,
      required this.prixVeille,
      });

  //And now let's create the function that will map the json into a list
  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      codeISIN: json['CodeISIN'] ?? '',
      codeMN: json['CodeMN'] ?? '',
      groupe: json['Groupe'] ?? '',
      heure: json['Heure'] ?? '',
      name: json['Name'] ?? '',
      prixVeille: json['PrixVeille'].toString()  ,
    );
  }
}
