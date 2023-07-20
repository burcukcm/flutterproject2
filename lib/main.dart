import 'package:flutter/material.dart';
import 'package:flutterproject/ikincisayfa.dart';
import 'package:flutterproject/ucuncusayfa.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.dashboard_outlined,color: Colors.white),iconSize: 30,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ucuncusayfa()));
            }
        ),
        backgroundColor: Colors.lightBlue,
        title: const Center(child: Text("MİRSAD ASSİSTANT",style:TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('resimler/code.jpg'),//arka plan resmi
            fit: BoxFit.cover, // resmi boyutlandırır ve orantılar.
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Align(
                alignment: Alignment.center,
                child: Text("\"WELCOME !\"",style:TextStyle(fontSize: 50,color: Colors.white, fontStyle: FontStyle.italic,))),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 175,
                height: 50,
                child: ElevatedButton(
                  child: const Text("NEW",style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ikinciSayfa()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 5,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );

  }
}
