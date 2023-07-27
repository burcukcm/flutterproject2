import 'package:flutter/material.dart';
import 'package:flutterproject/Navigation/navigation_helper.dart';
import 'package:flutterproject/View/home_view.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:flutterproject/helper/database_helper.dart';

class SecondView extends StatefulWidget {
  final Map<String, dynamic>? data;

  const SecondView({Key? key, this.data}) : super(key: key);

  @override
  _SecondViewState createState() => _SecondViewState();
}
class _SecondViewState extends State<SecondView> {
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
          child: Padding(
            padding: EdgeInsets.only(right: AppSize.paddingSize),
            child: Text(
              AppStrings.projectLabel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: AppColors.sixthColor),
          iconSize: AppSize.iconSize,
          onPressed: () {
            NavigationHelper.navigateToPage(context, const HomeViev());
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
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppSize.paddingRight,left:AppSize.paddingLeft),
                    child: TextFormField(
                      controller: titleController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        labelText: AppStrings.titleText,
                        fillColor: AppColors.sixthColor,
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.sizedBoxHeight),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSize.paddingRight,left:AppSize.paddingLeft),
                    child: TextFormField(
                      controller: portController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        labelText: AppStrings.portText,
                        fillColor: AppColors.sixthColor,
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.sizedBoxHeight),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSize.paddingRight,left:AppSize.paddingLeft),
                    child: TextFormField(
                      controller: branchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        labelText: AppStrings.branchText,
                        fillColor: AppColors.sixthColor,
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.sizedBoxHeight),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSize.paddingRight,left:AppSize.paddingLeft),
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: const InputDecoration(
                        labelText: AppStrings.dateText,
                        fillColor: AppColors.sixthColor,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.paddingSize),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sixthColor,
                        side: const BorderSide(color: AppColors.seventhColor, width: BorderSize.borderWidth),
                      ),
                      onPressed: _saveData,
                      child: const Text(
                        AppStrings.saveText,
                        style: TextStyle(
                          color: AppColors.thirdColor,
                          fontSize: Font.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
    String branch = branchController.text;
    String date = dateController.text;

    try {
      port = int.parse(portController.text);
      if (port < 0) {
        throw const FormatException();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.errorText),
          content: const Text(AppStrings.invalidText),
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

    if (title.isNotEmpty && portController.text.isNotEmpty && branch.isNotEmpty && date.isNotEmpty) {
      final newData = {
        'id': widget.data != null ? widget.data!['id'] : null,
        'title': title,
        'port': port,
        'branch': branch,
        'date': date,
      };
      if (widget.data != null) {
        dbHelper.updateData(newData);
      } else {
        dbHelper.insertData(title, port, branch, date);
      }
      titleController.clear();
      portController.clear();
      branchController.clear();
      dateController.clear();
    } else {
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
    }
  }
}
