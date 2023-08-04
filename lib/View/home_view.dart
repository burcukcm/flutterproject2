import 'package:flutter/material.dart';
import 'package:flutterproject/ViewModel/home_view_model.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: const Scaffold(
        appBar: MyAppBar1(),
        body: MyDecoratedBox(),
      ),
    );
  }
}

class MyDecoratedBox extends StatelessWidget {
  const MyDecoratedBox({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    const double sizedBoxHeightButton = 50.0;

    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.imagePath1),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.entryText,
              style: TextStyle(
                fontSize: Font.entryFont,
                color: AppColors.sixthColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: AppSize.sizedBoxWidth,
              height: sizedBoxHeightButton,
              child: ElevatedButton(
                onPressed: () {
                  homeViewModel.navigateToSecondView(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(BorderSize.borderRadiusCircular),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  AppStrings.newText,
                  style: TextStyle(
                    color: AppColors.thirdColor,
                    fontSize: Font.buttonFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class MyAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar1({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.dashboard_outlined, color: AppColors.sixthColor),
        iconSize: AppSize.iconSize,
        onPressed: () {
          homeViewModel.navigateToThirdView(context);
        },
      ),
      backgroundColor: AppColors.fifthColor,
      title: const Center(
        child: Padding(
          padding: EdgeInsets.only(right: AppSize.paddingRightBig),
          child: Text(
            AppStrings.projectLabel,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
