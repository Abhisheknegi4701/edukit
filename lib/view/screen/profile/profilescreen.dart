
import 'dart:ui';

import 'package:edukit/view/screen/signup/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/repository/allrepo.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/globalmethod.dart';
import '../../../utill/images.dart';
import 'editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int delayedAmount = 500;
  String userName = "";
  String userEmail = "";
  String userAddress = "";
  String userPassword = "";
  bool passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Image.asset(Images.eiffelTower,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    color: Color(0xf4ffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: const Divider(
                            thickness: 5,
                            color: ColorResources.borderCOLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        basicTextField(context, userName, "Name"),
                        const SizedBox(
                          height: 5,
                        ),
                        basicTextField(context, userEmail, "Email"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text("Password", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.blackCOLOR),),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(passwordVisible ? userPassword : "**********", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.blackCOLOR),)),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        basicTextField(context, userAddress, "Address"),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile())).then((value){
                     if(value){
                       getProfile();
                     }
                   });
                  }, icon: const Icon(Icons.edit,
                  size: Dimensions.FONT_SIZE_OVER_LARGE,
                  color: ColorResources.searchBg,
                ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              height: 50,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_OVER_LARGE, color: ColorResources.whiteCOL0R),
                  ),
                  Text(
                    "Your Profile Details", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DelayedAnimation(
        delay: delayedAmount * 15000,
        child: GestureDetector(
          onTap: (){
            logOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 50,53,82),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.logout, color: ColorResources.whiteCOL0R,),
                Text(
                  "Log Out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
                ),
              ],
            ),
          ),
        ), ),
    );
  }

  basicTextField(BuildContext context, String value, String hint){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Text(hint, style: const TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.blackCOLOR),),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.blackCOLOR),),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     userEmail = sharedPreferences.getString(AppConstants.sPEmail) ?? "";
    userPassword = sharedPreferences.getString(AppConstants.sPPassword) ?? "";
    userName = sharedPreferences.getString(AppConstants.sPName) ?? "";
    userAddress = sharedPreferences.getString(AppConstants.sPAddress) ?? "";
    setState(() {});
  }

}
