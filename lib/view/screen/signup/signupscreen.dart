
import 'dart:ui';

import 'package:edukit/helper/repository/allrepo.dart';
import 'package:edukit/model/address.dart';
import 'package:edukit/utill/color_resources.dart';
import 'package:edukit/utill/dimensions.dart';
import 'package:edukit/utill/images.dart';
import 'package:edukit/view/base/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utill/color.dart';
import '../../../utill/globalmethod.dart';
import '../../../utill/styles.dart';
import '../login/loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  double sigmaX = 0.0;
  double sigmaY = 0.0;
  double imageHeight = 0.0;
  bool middleTitle = true;
  bool floatingButton = true;
  final int delayedAmount = 500;
  bool scrolling = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  String myAddress = "";
  Address addresses = Address(postOffice: []);
  bool passwordVisible = true;
  bool signUp = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      scrolling = scrollController.position.isScrollingNotifier.value;
      imageHeight = MediaQuery.of(context).size.height - (scrollController.position.pixels);
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent / 1.1){
        sigmaX = 8.0;
        sigmaY = 8.0;
      }else{
        sigmaX = 0.0;
        sigmaY = 0.0;
      }
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent / 5){
        middleTitle = false;
        floatingButton = false;
      }else{
        middleTitle = true;
        floatingButton = true;
      }
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      imageHeight = MediaQuery.of(context).size.height;
    });

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Image.asset(Images.eiffelTower,
                width: MediaQuery.of(context).size.width,
                height: imageHeight,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                ),
                middleTitle ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  height: 100,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_OVER_LARGE, color: ColorResources.whiteCOL0R),
                      ),
                      Text(
                        "Register Yourself Here.", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
                      ),
                    ],
                  ),
                ) : Container(),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    color: Color(0xf4ffffff),
                  ),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
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
                          TextFormField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            autofocus: false,
                            style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              errorText: validateFields(nameController.text, "Name", "Enter Name"),
                              hintText: "Name",
                              hintStyle: poppinsRegular.copyWith(color: ColorResources.blackCOLOR),
                              errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: ColorResources.blackCOLOR,
                                    width: 2
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: ColorResources.blackCOLOR,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (s) {
                              formKey.currentState!.validate();
                              setState(() {});
                            },
                            validator: (val){
                              return validateFields(nameController.text, "Name", "Enter Name");
                            },
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            autofocus: false,
                            style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              errorText: validateFields(emailController.text, "Email", "Enter Email"),
                              hintText: "Email",
                              hintStyle: poppinsRegular.copyWith(color: ColorResources.blackCOLOR),
                              errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: ColorResources.blackCOLOR,
                                    width: 2
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: ColorResources.blackCOLOR,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (s) {
                              formKey.currentState!.validate();
                              setState(() {});
                            },
                            validator: (val){
                              return validateFields(emailController.text, "Email", "Enter Email");
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            autofocus: false,
                            obscureText: passwordVisible,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
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
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              labelText: "Password",
                              hintText: "Password",
                              errorText: validateFields(passwordController.text, "Password", "Enter Password"),
                              errorStyle: TextStyle(color: CustomColors.errorColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: CustomColors.greenButton,
                                    width: 2
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: CustomColors.textBlack,
                                    width: 2
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: CustomColors.textBlack,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (s) {
                              formKey.currentState!.validate();
                              setState(() {});
                            },
                            validator: (val){
                              return validateFields(passwordController.text, "Password", "Enter Password");
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pinCodeController,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            autofocus: false,
                            style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              errorText: validateFields(pinCodeController.text, "PinCode", "Enter Pin Code"),
                              hintText: "Pincode",
                              hintStyle: poppinsRegular.copyWith(color: ColorResources.blackCOLOR),
                              errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: ColorResources.blackCOLOR,
                                    width: 2
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: ColorResources.blackCOLOR,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (s) async {
                              formKey.currentState!.validate();
                              if(s.length == 6){
                                setState(() {});
                                addresses = await getAddress(s);
                              }
                              setState(() {});
                            },
                            validator: (val){
                              return validateFields(pinCodeController.text, "PinCode", "Enter Pin Code");
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
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
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  signUp = true;
                                });
                                signUpProcess(nameController.text, emailController.text, passwordController.text, myAddress).then((value) async {
                                  if(value){
                                    setState(() {
                                      signUp = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                                  }else{
                                    setState(() {
                                      signUp = false;
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
                                child: signUp ? const CircularProgressIndicator(color: Colors.white,)  : Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomColors.textBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                                )),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          middleTitle? Container() :Container(
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
                    "Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_OVER_LARGE, color: ColorResources.whiteCOL0R),
                  ),
                  Text(
                    "Register Yourself Here.", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingButton? FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 50,53,82),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.login, color: ColorResources.whiteCOL0R,),
      ):
      DelayedAnimation(
        delay: delayedAmount * 15000,
          child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 50,53,82),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.login, color: ColorResources.whiteCOL0R,),
              Text(
                " Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
              ),
            ],
          ),
        ),
      ), ),
    );
  }

}
