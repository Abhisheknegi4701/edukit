
import 'dart:ui';

import 'package:edukit/helper/repository/allrepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/address.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/globalmethod.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/snackbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final int delayedAmount = 500;
  bool editBasicInfo = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  bool passwordVisible = true;
  bool editProfileB = false;
  final formKey = GlobalKey<FormState>();
  String myAddress = "";
  Address addresses = Address(postOffice: []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfile();
  }

  Future<void> setProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    nameController.text = sharedPreferences.getString(AppConstants.sPName) ?? "";
    emailController.text = sharedPreferences.getString(AppConstants.sPEmail) ?? "";
    passwordController.text = sharedPreferences.getString(AppConstants.sPPassword) ?? "";
    myAddress = sharedPreferences.getString(AppConstants.sPAddress) ?? "";
    pinCodeController.text =  myAddress.substring(myAddress.length - 7, myAddress.length - 1);
    setState(() {});
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
                    child: Form(
                      key: formKey,
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
                          basicTextField(context, nameController, "Name", "Enter Name", false),
                          const SizedBox(
                            height: 5,
                          ),
                          basicTextField(context, emailController, "Email", "Enter Email", false),
                          const SizedBox(
                            height: 5,
                          ),
                          basicTextField(context, passwordController, "Password", "Enter Password", false),
                          const SizedBox(
                            height: 5,
                          ),
                          basicTextField(context, pinCodeController, "Pin Code", "Enter Pin Code", false),
                          const SizedBox(
                            height: 10,
                          ),
                          addresses.postOffice!.isNotEmpty ? DropdownButtonFormField(
                            value: addresses.postOffice![0],
                            isDense: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                            borderRadius: BorderRadius.circular(10),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            items: addresses.postOffice!.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                  child: Text("${items.name}, ${items.branchType}, ${items.block}, "
                                      "${items.district}, ${items.state}, ${items.country}, "
                                      "${items.pincode}.", style: const TextStyle(fontWeight: FontWeight.w500),),
                                ),
                              );
                            }).toList(),
                            onChanged: (items) {
                              if(items != null){
                                setState(() {
                                  myAddress = "${items.name}, ${items.branchType}, ${items.block}, ${items.district}, ${items.state}, ${items.country}, ${items.pincode}.";
                                });
                              }
                            },
                          )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  editProfileB = true;
                                });
                                editProfile(nameController.text, emailController.text, passwordController.text, myAddress).then((value) async {
                                  if(value){
                                    setState(() {
                                      editProfileB = false;
                                    });
                                    Navigator.pop(context, true);
                                  }else{
                                    setState(() {
                                      editProfileB = false;
                                    });
                                    showCustomSnackBar("Server Error Please try Again later.", context);
                                  }
                                });
                              }
                            },
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                padding:
                                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: CustomColors.greenButton),
                                child: editProfileB ? const CircularProgressIndicator(color: Colors.white,)  : Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomColors.textBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                                )),
                          ),
                        ],
                      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_downward,
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
                    "Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_OVER_LARGE, color: ColorResources.whiteCOL0R),
                  ),
                  Text(
                    "You can Edit Profile Details", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  basicTextField(BuildContext context, TextEditingController controller, String hint, String error, bool empty){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Text(hint, style: const TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.blackCOLOR),)),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: TextFormField(
              controller: controller,
              //textAlign: TextAlign.center,
              maxLines: 1,
              enabled: editBasicInfo,
              obscureText: hint == "Password" ? passwordVisible: false,
              autofocus: false,
              style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                suffixIcon: hint == "Password" ? IconButton(
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
                ) : const SizedBox(width: 0,),
                labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: editBasicInfo? empty? validateFields(controller.text, hint, error): controller.text.isNotEmpty? validateFields(controller.text, hint, error): null: null,
                hintText: hint,
                hintStyle: poppinsRegular.copyWith(color: ColorResources.blackCOLOR),
                errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                      color: Colors.green,
                      width: editBasicInfo? 2 : 0
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                      color: editBasicInfo? ColorResources.blackCOLOR: ColorResources.whiteCOL0R,
                      width: editBasicInfo? 2 : 0
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: editBasicInfo? 2 : 0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: ColorResources.blackCOLOR,
                    width: editBasicInfo? 2 : 0,
                  ),
                ),
              ),
              onChanged: (s) async {
                formKey.currentState!.validate();
                if(hint == "Pin Code"){
                  if(s.length == 6){
                    setState(() {});
                    addresses = await getAddress(s);
                  }
                }
                setState(() {});
              },
              validator: (val){
                return editBasicInfo? empty? validateFields(controller.text, hint, error): controller.text.isNotEmpty? validateFields(controller.text, hint, error): null: null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      ],
    );
  }

}
