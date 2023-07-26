import 'package:flutter/material.dart';
import 'package:flutterproject/View/SecondPage.dart';
import 'package:flutterproject/View/ThirdPage.dart';
import 'package:flutterproject/constants/app_constants.dart';
import 'package:flutterproject/Navigation/navigationHelper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar1(),
      body: MyDecoratedBox(),
    );
  }
}

class MyDecoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                fontSize: Font.entryfont,
                color: AppColors.sixthColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: AppSize.sizedBoxWidth,
              height: AppSize.sizedBoxheight,
              child: ElevatedButton(
                child: const Text(
                  AppStrings.newText,
                  style: TextStyle(
                    color: AppColors.thirdColor,
                    fontSize: Font.buttonfont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  NavigationHelper.navigateToPage(context, const SecondPage());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BorderSize.borderRadiusCircular),
                  ),
                  backgroundColor: Colors.white,
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
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.dashboard_outlined, color: AppColors.sixthColor),
        iconSize: AppSize.iconSize,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ThirdPage(),
            ),
          );
        },
      ),
      backgroundColor: AppColors.fifthColor,
      title: const Center(
        child: Padding(
          padding: EdgeInsets.only(right: AppSize.paddingRightbig),
          child: Text(
            AppStrings.projectlabel,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}





