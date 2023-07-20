import 'package:flutter/material.dart';
import 'package:flutterproject/ucuncusayfa.dart';

class ikinciSayfa extends StatefulWidget {
  const ikinciSayfa({Key? key});

  @override
  State<ikinciSayfa> createState() => _ikinciSayfaState();
}
class _ikinciSayfaState extends State<ikinciSayfa> {
  String Ad = '';
  String Soyad = '';
  String Rutbe = '';
  String Sicil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(child: Text("MİRSAD ASSİSTANT", style: TextStyle(fontWeight: FontWeight.bold))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.white),
            iconSize: 30,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ucuncusayfa()),);
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('resimler/code.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: Ad,
                    onChanged: (value) {
                      setState(() {
                        Ad = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Ad:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: Soyad,
                    onChanged: (value) {
                      setState(() {
                        Soyad = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Soyad:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: Rutbe,
                    onChanged: (value) {
                      setState(() {
                        Rutbe = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Rütbe:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: Sicil,
                    onChanged: (value) {
                      setState(() {
                        Sicil= value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Sicil:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  "-SHOW CURRENT DATA-",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ucuncusayfa()),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
