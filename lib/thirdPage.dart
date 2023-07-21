import 'package:flutter/material.dart';
import 'package:flutterproject/Infos.dart';
import 'package:flutterproject/dbhelper.dart';
import 'package:flutterproject/secondPage.dart';

class thirdPage extends StatefulWidget {
  const thirdPage({Key? key});

  @override
  State<thirdPage> createState() => _thirdPageState();
}

class _thirdPageState extends State<thirdPage> {
  final Dbhelper = DatabaseHelper.instance;
  List<Infos> infoList = [];

  @override
  void initState() {
    super.initState();
    _loadData(); // Verileri yükleme işlemi için initState içinde çağırıyoruz.
  }

  void _loadData() async {
    List<Infos> list = await Dbhelper.queryAll(); // Tüm verileri alır
    setState(() {
      infoList = list; // Verileri günceller ve GridView'e yansıtır
    });
  }
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
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('photos/code.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Scrollbar(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Griddeki sütun sayısı
                mainAxisSpacing: 10, // Ana eksen aralığı
                crossAxisSpacing: 10, // Yatay eksen aralığı
                childAspectRatio: 1, // Çocuklar arasındaki en boy oranı
              ),
              itemCount: infoList.length, // Kutu sayısı, artık veri listesinin uzunluğu kadar olacak
              itemBuilder: (context, index) {
                Infos info = infoList[index]; // Her bir veri için
                return Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(info.name), // Her bir bilgi alanını burada gösterin
                      Text(info.surname),
                      Text(info.rank),
                      Text(info.record.toString()),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        // bottom nav bar kısmına yükseklik ve genişlik vermek için sizedboxa aldık.
        width: double.infinity,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                side: const BorderSide(color: Colors.black38, width: 2.0),
              ),
              child: const Text(
                "REFRESH",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _loadData(); // Sayfayı yenilemek için verileri tekrar yükle
              },
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                side: const BorderSide(color: Colors.black38, width: 2.0),
              ),
              child: const Text(
                "NEW",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const secondPage()),
                ); // tıklayınca ikinci sayfaya dönüyor
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
