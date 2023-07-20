import 'package:flutter/material.dart';
import 'package:flutterproject/ikincisayfa.dart';

class ucuncusayfa extends StatefulWidget {
  const ucuncusayfa({super.key});

  @override
  State<ucuncusayfa> createState() => _ucuncusayfaState();
}
class _ucuncusayfaState extends State<ucuncusayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(child: Text("MİRSAD ASSİSTANT",style:TextStyle(fontWeight: FontWeight.bold))),
        leading: IconButton(
            icon: const Icon( Icons.arrow_circle_left_outlined, color: Colors.white), iconSize: 30,
            onPressed: (){
              Navigator.pop(context); // geldiği sayfaya döner.
            }
        ),
      ),
        body:
        DecoratedBox(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('resimler/code.jpg'), //arka plan resmi
        fit: BoxFit.cover,
    ),
    ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
      child: Scrollbar(
      child: GridView.builder(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Griddeki sütun sayısı
        mainAxisSpacing: 10, // Ana eksen aralığı
        crossAxisSpacing: 10, // Yatay eksen aralığı
        childAspectRatio: 1, // Çocuklar arasındaki en boy oranı
            ),
            itemCount: 4, // Kutu sayısı
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
              );
             },
           ),
          ),
         ),
        ),
      bottomNavigationBar: SizedBox(//bottom nav bar kısmına yükleklik genişlik vermek için sizedboxa aldık.
        width: 10,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                  side: BorderSide(color: Colors.black38, width: 2.0), //border ekledim
              ),
              child: const Text("REFRESH",style: TextStyle(color:Colors.deepPurple,fontSize: 15,fontWeight: FontWeight.bold)),
              onPressed: () {
              },
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54,
                side: BorderSide(color: Colors.black38, width: 2.0),
              ),
              child:const Text("NEW",style: TextStyle(color:Colors.deepPurple,fontSize: 15,fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ikinciSayfa()));// tıklayınca ikinci sayfaya dönüyor
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}