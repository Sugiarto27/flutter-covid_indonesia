import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid_indo/model_covid.dart';
import 'detail_positif.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Covid covid;
  CovidTot covidTot;

  void getCovid() {
    Covid.ambidata().then((value) {
      setState(() {
        covid = value;
      });
    });
  }

  void getTot() {
    CovidTot.ambilTotal().then((val) {
      setState(() {
        covidTot = val;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCovid();
    getTot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'COVID-19',
        home: Scaffold(
            appBar: AppBar(
              title: Text('COVID-19'),
            ),
            body: Container(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  children: [
                    MyCovid(
                      judul: "Postif",
                      warnaCard: Colors.orange,
                      positifBaru: (covid != null) ? covid.positif : 0,
                      totalPositif: (covidTot != null) ? covidTot.positif : 0,
                    ),
                    MyCovid(
                      judul: "Meninggal",
                      warnaCard: Colors.red,
                      positifBaru: (covid != null) ? covid.meninggal : 0,
                      totalPositif: (covidTot != null) ? covidTot.meninggal : 0,
                    ),
                    MyCovid(
                      judul: "Sembuh",
                      warnaCard: Colors.green,
                      positifBaru: (covid != null) ? covid.sembuh : 0,
                      totalPositif: (covidTot != null) ? covidTot.sembuh : 0,
                    )
                  ],
                ))));
  }
}

class MyCovid extends StatelessWidget {
  MyCovid({this.judul, this.warnaCard, this.positifBaru, this.totalPositif});

  String judul;
  Color warnaCard;
  int positifBaru;
  int totalPositif;
  var formater = new NumberFormat("#,##0");

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detailpositif(namajudul: judul)));
            },
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      color: warnaCard, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard,
                              color: Colors.white,
                            ),
                            Text(
                              judul,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 30,
                        child: VerticalDivider(
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("+" + formater.format(positifBaru),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Text(
                              "Kasus Baru",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(formater.format(totalPositif),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Text(
                              "Total " + judul,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      )),
                    ],
                  )),
            )));
  }
}
