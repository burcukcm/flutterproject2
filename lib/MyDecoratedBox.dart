
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/View/SecondPage.dart';
import 'package:flutterproject/View/ThirdPage.dart';
import 'package:flutterproject/constants/a.constants.dart';
import 'package:flutterproject/navigationHelper.dart';

class MyDecoratedBox extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.imagePath1),
          fit: BoxFit.cover,
        ),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Align(
              alignment: Alignment.center,
              child: Text("\"WELCOME !\"",style:TextStyle(fontSize: 50,color: Colors.white, fontStyle: FontStyle.italic,))
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 175,
              height: 50,
              child: ElevatedButton(
                child: Text("NEW",style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    leading: IconButton(
    icon: const Icon(Icons.dashboard_outlined,color:AppColors.sixthColor),iconSize: AppSize.iconSize,
    onPressed: (){
      NavigationHelper.navigateToThirdPage(context);
       }
     ),
    backgroundColor: AppColors.fifthColor,
    title: const Center(child: Padding(
      padding: const EdgeInsets.only(right:AppSize.paddingRight),
    child: Text("MİRSAD ASSİSTANT",style:TextStyle(fontWeight: FontWeight.bold)),
        )
      ),
    );
  }
}



