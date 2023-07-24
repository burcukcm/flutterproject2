import 'package:flutter/material.dart';
import 'package:flutterproject/View/ThirdPage.dart';
import 'package:flutterproject/constants/a.constants.dart';
import 'package:flutterproject/helper/databasehelper.dart';
import 'package:flutterproject/navigationHelper.dart';


const double sizedBoxHeight = 16.0;

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
        backgroundColor: AppColors.primaryColor,
        title: const Center(
          child: Text(
            "MİRSAD ASSİSTANT",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: AppColors.sixthColor),
          iconSize:AppSize.iconSize,
          onPressed: () {
            NavigationHelper.navigateToHomePage(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_circle_right_outlined, color:AppColors.sixthColor),
            iconSize: AppSize.iconSize,
            onPressed: () {
              NavigationHelper.navigateToThirdPage(context);
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.imagePath1),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title:',
                      fillColor:AppColors.sixthColor,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: sizedBoxHeight),
                  TextFormField(
                    controller: portController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Port number:',
                      fillColor: AppColors.sixthColor,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: sizedBoxHeight),
                  TextFormField(
                    controller: branchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Branch Name:',
                      fillColor:AppColors.sixthColor,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: sizedBoxHeight),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: const InputDecoration(
                      labelText: 'Date:',
                      fillColor:AppColors.sixthColor,
                      filled: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sixthColor,
                        side: const BorderSide(color:AppColors.seventhColor, width: 2.0),
                      ),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                          color: AppColors.thirdColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _saveData();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
