import 'package:flutter/material.dart';
import 'model_covid.dart';
import 'package:intl/intl.dart';

class Pagedetail extends StatefulWidget {
  Pagedetail({this.namajudul});
  final String namajudul;

  @override
  _PagedetailState createState() => _PagedetailState();
}

class _PagedetailState extends State<Pagedetail> {
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
                var totKasus = covidProvinsi[index].meninggal;
                return Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(namaProv),
                        Text("Total Meninggal Dunia"),
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
