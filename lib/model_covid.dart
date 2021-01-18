import 'package:http/http.dart' as http;
import 'dart:convert';

class Covid {
  int positif;
  int meninggal;
  int sembuh;

  Covid({this.positif, this.meninggal, this.sembuh});

  factory Covid.fromJson(Map<String, dynamic> object) {
    return Covid(
        positif: object['jumlah_positif'],
        meninggal: object['jumlah_meninggal'],
        sembuh: object['jumlah_sembuh']);
  }

  static Future<Covid> ambidata() async {
    String apiUrl = 'https://data.covid19.go.id/public/api/update.json';
    var jsonRes =
        await http.get(apiUrl, headers: {"Accept": "application/json"});
    if (jsonRes.statusCode == 200) {
      var hasilJson = json.decode(jsonRes.body);
      var result = (hasilJson as Map<String, dynamic>)['update']['penambahan'];
      return Covid.fromJson(result);
    } else {
      print('Failed to load data');
    }
  }
}

class CovidTot {
  int positif;
  int meninggal;
  int sembuh;

  CovidTot({this.positif, this.meninggal, this.sembuh});

  factory CovidTot.fromJson(Map<String, dynamic> object) {
    return CovidTot(
        positif: object['jumlah_positif'],
        meninggal: object['jumlah_meninggal'],
        sembuh: object['jumlah_sembuh']);
  }

  static Future<CovidTot> ambilTotal() async {
    String apiUrl = 'https://data.covid19.go.id/public/api/update.json';
    var jsonRes =
        await http.get(apiUrl, headers: {"Accept": "application/json"});
    if (jsonRes.statusCode == 200) {
      var hasilJson = json.decode(jsonRes.body);
      var result = (hasilJson as Map<String, dynamic>)['update']['total'];
      return CovidTot.fromJson(result);
    } else {
      print('Failed to load data!');
    }
  }
}

class CovidProvinsi {
  String kunci;
  int positif;
  int meninggal;
  int sembuh;

  CovidProvinsi({this.kunci, this.positif, this.meninggal, this.sembuh});

  factory CovidProvinsi.fromJson(Map<String, dynamic> object) {
    return CovidProvinsi(
        kunci: object['key'],
        positif: object['jumlah_kasus'],
        meninggal: object['jumlah_meninggal'],
        sembuh: object['jumlah_sembuh']);
  }
  static Future<List<CovidProvinsi>> ambilProv() async {
    String apiUrl = 'https://data.covid19.go.id/public/api/prov.json';
    var jsonRes =
        await http.get(apiUrl, headers: {"Accept": "application/json"});
    if (jsonRes.statusCode == 200) {
      var hasilJson = json.decode(jsonRes.body);
      List<dynamic> result = (hasilJson as Map<String, dynamic>)['list_data'];

      List<CovidProvinsi> listData = [];

      for (int i = 0; i < result.length; i++)
        listData.add(CovidProvinsi.fromJson(result[i]));

      return listData;
    } else {
      print('Failed to load data!');
    }
  }
}
