import 'package:flutter/material.dart';
import 'package:flutterproject/ViewModel/second_view_model.dart';
import 'package:flutterproject/constants/app_constants.dart';

class SecondView extends StatefulWidget {
  final Map<String, dynamic>? data;

  const SecondView({Key? key, this.data}) : super(key: key);

  @override
  _SecondViewState createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  late SecondViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SecondViewModel();
    _viewModel.initializeData(widget.data);
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
          icon: const Icon(Icons.arrow_circle_left_outlined,
              color: AppColors.sixthColor),
          iconSize: AppSize.iconSize,
          onPressed: () {
            _viewModel.navigateToHomeView(context);
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
                    padding: const EdgeInsets.only(
                        right: AppSize.paddingRight, left: AppSize.paddingLeft),
                    child: TextFormField(
                      controller: _viewModel.titleController,
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
                    padding: const EdgeInsets.only(
                        right: AppSize.paddingRight, left: AppSize.paddingLeft),
                    child: TextFormField(
                      controller: _viewModel.portController,
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
                    padding: const EdgeInsets.only(
                        right: AppSize.paddingRight, left: AppSize.paddingLeft),
                    child: TextFormField(
                      controller: _viewModel.branchController,
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
                    padding: const EdgeInsets.only(
                        right: AppSize.paddingRight, left: AppSize.paddingLeft),
                    child: TextFormField(
                      controller: _viewModel.dateController,
                      readOnly: true,
                      onTap: () => _viewModel.selectDate(context),
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
                        side: const BorderSide(
                            color: AppColors.seventhColor,
                            width: BorderSize.borderWidth),
                      ),
                      onPressed: () =>
                          _viewModel.saveData(context, widget.data),
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
}
