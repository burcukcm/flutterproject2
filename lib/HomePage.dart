import 'package:flutterproject/SecondPage.dart';
import 'package:flutterproject/ThirdPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirsad Assistant',
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
            }
        ),
        backgroundColor: Colors.lightBlue,
        title: const Center(child: Text("MİRSAD ASSİSTANT",style:TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('photos/code.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Align(
                alignment: Alignment.center,
                child: Text("\"WELCOME !\"",style:TextStyle(fontSize: 50,color: Colors.white, fontStyle: FontStyle.italic,))
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 175,
                height: 50,
                child: ElevatedButton(
                  child: Text("NEW",style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    backgroundColor: Colors.white,
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
