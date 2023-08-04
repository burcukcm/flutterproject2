import 'package:flutter/material.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:flutterproject/ViewModel/third_view_model.dart';
import 'package:provider/provider.dart';

class ThirdView extends StatelessWidget {
  const ThirdView({Key? key});

  static const double textFontSize = 20.0; // app_constants sayfasına eklediğimde burada tanımadı o yüzden burada tanımlıyorum.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThirdViewModel>(
      create: (_) => ThirdViewModel(context),
      builder: (context, _) {
        return _buildScaffold(context);
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final viewModel = Provider.of<ThirdViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: AppSize.rightPaddingValue),
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
            viewModel.onBackPressed();
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
              itemCount: viewModel.dataList.length,
              itemBuilder: (context, index) {
                bool isServiceActive = viewModel.isServiceActiveList[index];
                return GestureDetector(
                  onTap: () {
                    viewModel.navigateToSecondPage(viewModel.dataList[index]);
                  },
                  child: Container(
                    color: viewModel.getServiceStatusColor(isServiceActive),
                    padding: const EdgeInsets.all(AppSize.padding1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                viewModel.showDeleteConfirmationDialog(
                                    context, viewModel.dataList[index]['id']);
                              },
                              child: const Icon(Icons.close,
                                  color: AppColors.seventhColor),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.titleText,
                            style: const TextStyle(
                              fontSize: ThirdView.textFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: viewModel.dataList[index]['title'],
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.portText,
                            style: const TextStyle(
                              fontSize: ThirdView.textFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: viewModel.dataList[index]['port']
                                    .toString(),
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.branchText,
                            style: const TextStyle(
                              fontSize: ThirdView.textFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: viewModel.dataList[index]['branch'],
                                style: const TextStyle(
                                  color: AppColors.seventhColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.dateText,
                            style: const TextStyle(
                              fontSize: ThirdView.textFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdColor,
                            ),
                            children: [
                              TextSpan(
                                text: viewModel.dataList[index]['date'],
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
        height: AppSize.sizedBoxHeight1,
        width: AppSize.sizedBoxWidth1,
        child: Container(
          color: AppColors.fifthColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sixthColor,
                  side: const BorderSide(
                      color: AppColors.seventhColor,
                      width: BorderSize.borderWidth),
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
                  viewModel.getData();
                },
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sixthColor,
                  side: const BorderSide(
                      color: AppColors.seventhColor,
                      width: BorderSize.borderWidth),
                ),
                child: const Text(
                  AppStrings.newText,
                  style: TextStyle(
                    color: AppColors.thirdColor,
                    fontSize: Font.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  viewModel.onBackPressed();
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
