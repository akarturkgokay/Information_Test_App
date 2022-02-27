import 'package:bilgi_testi_app/test_veri.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        appBar: AppBar(
          title: Text('Bilgi Testi Uygulaması'),
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SoruSayfasi(),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];

  TestVeri test_1 = TestVeri();

  void butonFonksiyonu(bool secilenButon) {
    if (test_1.testBittiMi() == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Bravo Testi Bitirdiniz.'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Başa Dön'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      test_1.testSifirla();
                      secimler = [];
                    });
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        test_1.getSoruYaniti() == secilenButon
            ? secimler.add(kDogruIconu)
            : secimler.add(kYanlisIconu);
        test_1.sonrakiSoru();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                test_1.getSoruMetni(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: secimler,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: RaisedButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(12),
                      color: Colors.red[400],
                      child: Icon(
                        Icons.thumb_down,
                        size: 30,
                      ),
                      onPressed: () {
                        butonFonksiyonu(false);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: RaisedButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(12),
                      color: Colors.green[400],
                      child: Icon(
                        Icons.thumb_up,
                        size: 30,
                      ),
                      onPressed: () {
                        butonFonksiyonu(true);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
