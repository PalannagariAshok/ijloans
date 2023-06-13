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

import '../../providers/ApiServices.dart';
import '../Pages/LandingPage.dart';

class OtpVerify extends StatefulWidget {
  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with CodeAutoFill {
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
    var ApiService = Provider.of<ApiServices>(context, listen: false);
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Verfiy OTP sent to ${ApiService.registerPhone}"),
      // ),
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
              Text(
                "OTP verfiy sent to ${ApiService.registerPhone}",
                style: TextStyle(fontSize: 20),
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Color.fromRGBO(24, 56, 113, 1),
                  activeColor: Color.fromRGBO(24, 56, 113, 1),
                  activeFillColor: hasError ? Colors.orange : Colors.white,
                ),
                validator: (v) {
                  if (v!.length < 6) {
                    return "Please Enter Six Digit OTP";
                  } else {
                    return null;
                  }
                },
                animationDuration: Duration(milliseconds: 300),
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: false,

                controller: _otp,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              _start == 0
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width / 4, 30)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ))),
                      // background
                      // foreground
                      onPressed: () async {
                        setState(() {
                          _start = 60;
                        });
                        startTimer();
                      },
                      child: Text('Resend',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          )),
                    )
                  : Text(
                      'Expires in ${_start}s',
                      style: TextStyle(fontSize: 14),
                    ),
              SizedBox(
                height: 20,
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
                  // verifyOTPCode();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new LandingPage()));
                },
                child: Text('Verify OTP',
                    style: TextStyle(
                      fontSize: 18,
                    )),
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
