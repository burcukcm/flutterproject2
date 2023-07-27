import 'package:flutter/material.dart';
import 'package:flutterproject/View/second_view.dart';
import 'package:flutterproject/helper/database_helper.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:flutterproject/Navigation/navigation_helper.dart';

class ThirdView extends StatefulWidget {

  const ThirdView({Key? key});

  @override
  _ThirdViewState createState() => _ThirdViewState();
}
class _ThirdViewState extends State<ThirdView> {
  final dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> dataList = [];

  List<bool> isServiceActiveList = [true, false, true, true, false, true, true, false, true, false, true ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await _getData());

  }
  Future<void> _getData() async {
    dataList = await dbHelper.getAllData();
    setState(() {});
  }
  Color getServiceStatusColor(bool isServiceActive) {
    return isServiceActive ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.primaryColor,
        title: const Center(
          child: Padding(
             padding : EdgeInsets.only(right:AppSize.rightPaddingValue ),
            child: Text(AppStrings.projectLabel, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: AppColors.sixthColor),
          iconSize: AppSize.iconSize,
          onPressed: () {
            NavigationHelper.navigateToPage(context, const SecondView());
          },
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.imagePath1),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.padding2),
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
                bool isServiceActive = isServiceActiveList[index];
                return GestureDetector(
                  onTap: (){
                    _navigateToSecondPage(dataList[index]);
                  },
                  child: Container(
                    color: getServiceStatusColor(isServiceActive),
                    padding: const EdgeInsets.all(AppSize.padding1),
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
                              child: const Icon(Icons.close, color: AppColors.seventhColor),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Title: ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: dataList[index]['title'],
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Port: ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: dataList[index]['port'].toString(),
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Branch: ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: dataList[index]['branch'],
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'Date: ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: dataList[index]['date'],
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
        height: AppSize.sizedBoxHeight1, width: AppSize.sizedBoxWidth1,
        child: Container(  color: AppColors.fifthColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.sixthColor,
                  side: const BorderSide(color: AppColors.seventhColor, width: BorderSize.borderWidth),
                ),
                child: const Text(
                  AppStrings.refreshText,
                  style: TextStyle(
                    color: AppColors.thirdColor,
                    fontSize: Font.fontSize,
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
                  backgroundColor:AppColors.sixthColor,
                  side: const BorderSide(color: AppColors.seventhColor, width: BorderSize.borderWidth),
                ),
                child: const Text(
                  AppStrings.newText,
                  style: TextStyle(
                    color:AppColors.thirdColor,
                    fontSize: Font.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  NavigationHelper.navigateToPage(context, const SecondView());
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  void _navigateToSecondPage(Map<String, dynamic>? data) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => SecondView(data: data),
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




