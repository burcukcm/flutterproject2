import 'package:flutter/material.dart';
import 'package:flutterproject/ThirdPage.dart';
import 'package:flutterproject/databasehelper.dart';

class SecondPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const SecondPage({Key? key, this.data}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      titleController.text = widget.data!['title'];
      portController.text = widget.data!['port'].toString();
      branchController.text = widget.data!['branch'];
      dateController.text = widget.data!['date'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text(
            "MİRSAD ASSİSTANT",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context, _getDataMap());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.white),
            iconSize: 30,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
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
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: portController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Port number:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: branchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Branch Name:',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: const InputDecoration(
                      labelText: 'Date:',
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
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _saveData();
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _saveData() {
    final dbHelper = DatabaseHelper();
    String title = titleController.text;
    int port = int.tryParse(portController.text) ?? 0;
    String branchName = branchController.text;
    String date = dateController.text;

    if (title.isNotEmpty && portController.text.isNotEmpty && branchName.isNotEmpty && date.isNotEmpty) {
      final newData = {
        'id': widget.data != null ? widget.data!['id'] : null,
        'title': title,
        'port': port,
        'branch': branchName,
        'date': date,
      };

      if (widget.data != null) {
        dbHelper.updateData(newData);
      } else {
        dbHelper.insertData(title, port, branchName, date);
      }

      titleController.clear();
      portController.clear();
      branchController.clear();
      dateController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ERROR!'),
          content: const Text('Please fill in all fields.'),
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

  Map<String, dynamic> _getDataMap() {
    String title = titleController.text;
    int port = int.tryParse(portController.text) ?? 0;
    String branchName = branchController.text;
    String date = dateController.text;

    return {
      'id': widget.data != null ? widget.data!['id'] : null,
      'title': title,
      'port': port,
      'branch': branchName,
      'date': date,
    };
  }
}

