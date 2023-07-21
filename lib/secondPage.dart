import 'package:flutter/material.dart';
import 'package:flutterproject/Infos.dart';
import 'package:flutterproject/thirdPage.dart';
import 'dbhelper.dart';

class secondPage extends StatefulWidget {
  const secondPage({Key? key});

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {

  final Dbhelper = DatabaseHelper.instance; //VERİ TABANI İŞLEMLERİNİ GERÇEKLEŞTİRMEK İÇİN

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController recordController = TextEditingController();

  List<Infos> infoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
            child: Text("MİRSAD ASSİSTANT",
                style: TextStyle(fontWeight: FontWeight.bold))),
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_circle_left_outlined, color: Colors.white),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_circle_right_outlined,
                color: Colors.white),
            iconSize: 30,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => thirdPage()),
              );
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('photos/code.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController, // BU METOD İLE GÜNCEL KONTROL SAĞLANIYOR
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: surnameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Surname:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: rankController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Rank:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: recordController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Record:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black38, width: 2.0),
                ),
                child: const Text("INSERT DETAILS",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  String name = nameController.text;
                  String surname = surnameController.text;
                  String rank = rankController.text;
                  int record = int.parse(recordController.text);
                  _insert(name, surname, rank, record);
                },
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: const Text(
                  "-SHOW CURRENT DATA-",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => thirdPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insert(String name, String surname, String rank, int record) async {
    /* _insert nesnesi veritabanına eklenir. Eklenen veri, infoList listesine de eklenerek
     kullanıcı arayüzünde gösterilir.*/
    Infos infos = Infos(
      name: name,
      surname: surname,
      rank: rank,
      record: record,
    );
    final id = await Dbhelper.insert(infos);

    setState(() {
      infoList.add(infos);
    });
  }
}

