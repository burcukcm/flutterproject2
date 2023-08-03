import 'package:flutter/material.dart';
import 'package:flutterproject/Navigation/navigation_helper.dart';
import 'package:flutterproject/View/home_view.dart';
import 'package:flutterproject/helper/database_helper.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:flutterproject/Models/data_model.dart';

class SecondViewModel with ChangeNotifier {

  void navigateToHomeView(BuildContext context) {
    NavigationHelper.navigateToPage(context, const HomeView());
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void initializeData(Map<String, dynamic>? data) {
    if (data != null) {
      titleController.text = data['title'];
      portController.text = data['port'].toString();
      branchController.text = data['branch'];
      dateController.text = data['date'];
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      dateController.text =
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      notifyListeners();
    }
  }

  void saveData(BuildContext context, Map<String, dynamic>? data) {
    final dbHelper = DatabaseHelper();
    String title = titleController.text;
    String branch = branchController.text;
    String date = dateController.text;

    if (title.isEmpty || portController.text.isEmpty || branch.isEmpty || date.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.errorText),
          content: const Text(AppStrings.fillText),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(AppStrings.okText),
            ),
          ],
        ),
      );
      return;
    }

    int port;
    try {
      port = int.parse(portController.text);
      if (port <= 0) {
        throw const FormatException();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid port value. Please enter a valid port number.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final newData = {
      'id': data != null ? data ['id'] : null,
      'title': title,
      'port': port,
      'branch': branch,
      'date': date,
    };
    if (data != null) {
      dbHelper.updateData(newData);
    } else {
      dbHelper.addData(DataModel(title: title, port: port, branchName: branch, date: date));
    }
    titleController.clear();
    portController.clear();
    branchController.clear();
    dateController.clear();
  }
}
