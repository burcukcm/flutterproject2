import 'package:flutter/material.dart';
import 'package:flutterproject/Models/data_model.dart';
import 'package:flutterproject/Navigation/navigation_helper.dart';
import 'package:flutterproject/View/second_view.dart';
import 'package:flutterproject/helper/database_helper.dart';
import 'package:flutterproject/Constants/app_constants.dart';

class ThirdViewModel extends ChangeNotifier {
  final BuildContext context;
  final dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> dataList = [];
  List<bool> isServiceActiveList = [
    true,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    true
  ];

  ThirdViewModel(this.context) {
    getData();
  }

  Future<void> getData() async {
    dataList = await dbHelper.getAllData();
    notifyListeners();
  }

  Color getServiceStatusColor(bool isServiceActive) {
    return isServiceActive ? Colors.green : Colors.red;
  }

  void onBackPressed() {
    NavigationHelper.pop(context);
  }

  void navigateToSecondPage(Map<String, dynamic>? data) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => SecondView(data: data),
      ),
    );
    if (result != null) {
      if (data == null) {
        saveData(result);
      } else {
        updateData(result);
      }
    }
    getData();
  }

  void showDeleteConfirmationDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.deleteText),
          content: const Text(AppStrings.questionText),
          actions: <Widget>[
            TextButton(
              child: const Text(AppStrings.approveText),
              onPressed: () {
                deleteData(id);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(AppStrings.refuseText),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void saveData(Map<String, dynamic> newData) async {
    DataModel dataModel = DataModel(
        title: newData['title'],
        port: newData['port'],
        branchName: newData['branch'],
        date: newData['date']);

    if (dataModel.port > 0 &&
        dataModel.branchName.isNotEmpty &&
        dataModel.date.isNotEmpty) {
      dbHelper.addData(dataModel);
    } else {
      _showErrorDialog(AppStrings.fillText);
    }
  }

  void updateData(Map<String, dynamic> updatedData) async {
    try {
      await dbHelper.updateData(updatedData);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void deleteData(int id) async {
    await dbHelper.deleteData(id);
    getData();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.errorText),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.okText),
          ),
        ],
      ),
    );
  }
}
