import 'package:flutter/material.dart';
import 'model_covid.dart';
import 'package:intl/intl.dart';

class Detailpositif extends StatefulWidget {
  Detailpositif({this.namajudul});
  final String namajudul;

  @override
  _DetailpositifState createState() => _DetailpositifState();
}

class _DetailpositifState extends State<Detailpositif> {
  List covidProvinsi;

  var formater = new NumberFormat("#,##0");
  void getProv() {
    CovidProvinsi.ambilProv().then((listData) {
      setState(() {
        covidProvinsi = listData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProv();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail',
      home: Scaffold(
          appBar: AppBar(
            title: Text(
                (widget != null) ? 'Per Provinsi - ' + widget.namajudul : ''),
          ),
          body: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var namaProv = covidProvinsi[index].kunci;
                var totKasus = covidProvinsi[index].positif;
                return Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(namaProv),
                        Text("Total Kasus Positif"),
                        Text(formater.format(totKasus)),
                      ],
                    ));
              },
              itemCount: (covidProvinsi != null) ? covidProvinsi.length : 0,
            ),
          )),
    );
  }
}
