import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ijloans/components/Auth/signup.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../providers/ApiServices.dart';
import 'otpVerfiy.dart';

class SendOTP extends StatefulWidget {
  @override
  State<SendOTP> createState() => _SendOTPState();
}

class _SendOTPState extends State<SendOTP> with CodeAutoFill {
  FirebaseAuth auth = FirebaseAuth.instance;
  // ..text = "123456";
  String? appSignature;
  String? otpCode;

  Timer? _timer;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController _otp;
  int _start = 60;
  late TextEditingController _phone;
  String phoneErrorMsg = '';
  bool phoneError = false;

  var receivedID = '';

  void verifyUserPhoneNumber() async {
    var ApiService = await Provider.of<ApiServices>(context, listen: false);
    auth.verifyPhoneNumber(
      phoneNumber: "+91${ApiService.registerPhone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("ddddddddddd ${credential.smsCode}");
        // _otp = TextEditingController(text: credential.smsCode!);
        await auth.signInWithCredential(credential).then(
              (value) => print('Logged In Successfully'),
            );
        // _otp = TextEditingController(text: credential.smsCode!);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("vvvvvvvvv${verificationId} ${resendToken}");
        // String smsCode = '863215';
        setState(() {
          receivedID = verificationId;
        });

        // // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('TimeOut');
      },
    );
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: _otp.text,
    );
    await auth.signInWithCredential(credential).then((value) => {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new SignUpButton()))
        });
  }

  @override
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _listOPT() async {
    var value = await SmsAutoFill().listenForCode;
  }

  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    // _listOPT();
    // startTimer();
    _otp = TextEditingController();
    _phone = TextEditingController();
    // verifyUserPhoneNumber();
  }

  @override
  void dispose() {
    _otp.dispose();
    _phone.dispose();
    _timer!.cancel();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                width: 150.0,
                height: 100.0,
              ),
              // Text('${otpCode}'),
              // Container(
              //   child:  PinFieldAutoFill(
              //     decoration: UnderlineDecoration(
              //       textStyle: TextStyle(fontSize: 20, color: Colors.black),
              //       colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              //     ),
              //     codeLength: 4,
              //     onCodeSubmitted: (code) {},
              //     onCodeChanged: (code) {
              //       if (code!.length== 6) {
              //         FocusScope.of(context).requestFocus(FocusNode());
              //       }
              //     },
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _phone,
                maxLength: 10,
                validator: (value) {
                  String pattern =
                      r'^(?:\+?1[-.●]?)?\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value!))
                    return 'Enter a valid phone number';
                  else
                    return null;
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  isDense: true,
                  prefixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text('+91 ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  labelText: "Phone Number*",
                  errorText: phoneError == false ? null : phoneErrorMsg,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(24, 56, 113, 1)),
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                // background
                // foreground
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var ApiService =
                        await Provider.of<ApiServices>(context, listen: false);
                    ApiService.LoginPhoneNumber(_phone.text);
                    ApiService.UserProfile(_phone.text).then((el) {
                      print(el.runtimeType);

                      if (el is List<dynamic>) {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              child: OtpVerify(),
                            );
                          },
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Authentication failed, Please Signup");
                      }
                    });
                  }
                },
                child: Text('Send OTP',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _SendOTP() async {
    // Navigator.of(context).popUntil(ModalRoute.withName('/'));
    // Home.currentIndex=0;

    // Navigator.pushNamed(context, new LogeIn());
    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new LogeIn()));
    // setState(() {
    //   res = hello.response;
    // });
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
    setState(() {
      otpCode = code!;
    });
  }
}
