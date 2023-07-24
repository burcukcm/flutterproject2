import 'package:flutter/material.dart';
import 'package:flutterproject/SecondPage.dart';
import 'package:flutterproject/databasehelper.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    dataList = await dbHelper.getAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text("MİRSAD ASSİSTANT", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
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
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToSecondPage(dataList[index]);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _deleteData(dataList[index]['id']);
                              },
                              child: const Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        ),
                        Text(
                          'Title: ${dataList[index]['title']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Port: ${dataList[index]['port']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Branch: ${dataList[index]['branch']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Date: ${dataList[index]['date']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _getData();
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _navigateToSecondPage(null);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _navigateToSecondPage(Map<String, dynamic>? data) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(data: data),
      ),
    );
    if (result != null) {
      if (data == null) {
        _saveData(result);
      } else {
        _updateData(result);
      }
    }
    _getData();
  }

  void _saveData(Map<String, dynamic> newData) async {
    String title = newData['title'];
    int port = newData['port'];
    String branchName = newData['branch'];
    String date = newData['date'];

    if (title.isNotEmpty && port > 0 && branchName.isNotEmpty && date.isNotEmpty) {
      dbHelper.insertData(title, port, branchName, date);
    } else {
      _showErrorDialog("Please fill in all fields.");
    }
  }

  void _updateData(Map<String, dynamic> updatedData) async {
    try {
      await dbHelper.updateData(updatedData);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _deleteData(int id) async {
    await dbHelper.deleteData(id);
    _getData();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ERROR!'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}




