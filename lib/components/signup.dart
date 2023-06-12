import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/ApiServices.dart';
import 'otp.dart';

// ignore: use_key_in_widget_constructors
class SignUpButton extends StatefulWidget {
  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  var error = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Timer? _timer;
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _fullname;
  late TextEditingController _dob;
  late TextEditingController _aniversity;
  late TextEditingController _pincode;
  late TextEditingController _refferal;
  late TextEditingController otpController;
  var receivedID = '';
  String gender = '';
  String phoneErrorMsg = '';
  bool phoneError = false;

  var dropDownValue;

  final _formKey = GlobalKey<FormState>();
  int _radioValue = -1;

  List<String> cityList = ['Married', 'Unmarried'];

  void _handleRadioValueChange(value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          gender = '1';
          break;

        case 1:
          gender = '2';
          break;

        case 2:
          gender = '3';
          break;
      }
    });
  }

  // ------ [add the next block] ------
  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: "+917732084457",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("ddddddddddd");
        await auth.signInWithCredential(credential).then(
              (value) => print('Logged In Successfully'),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("vvvvvvvvv${verificationId} ${resendToken}");
        // String smsCode = '863215';

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
      smsCode: otpController.text,
    );
    await auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });

    _email = TextEditingController();
    _phone = TextEditingController();
    // _dob = TextEditingController();
    _fullname = TextEditingController();
    // _pincode = TextEditingController();
    // _refferal = TextEditingController();
    // _aniversity = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    // _aniversity.dispose();
    _fullname.dispose();
    // _dob.dispose();
    // _pincode.dispose();
    // _refferal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                //height:MediaQuery.of(context).size.height/1.639,
                child: ListView(
                  shrinkWrap: true,

                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 10),

                  /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                  /// Use [Axis.vertical] to scroll vertically.

                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'images/logo.png',
                      width: 120.0,
                      height: 120.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Verification Code will be sent to Mobile Number'),

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _fullname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Fullname';
                        } else if (value.length < 4) {
                          return 'Please Enter Min 4 Char';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        isDense: true,
                        labelText: "FullName*",
                        errorText: error == false ? null : '',
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
                    SizedBox(
                      height: error == false ? 20 : 0,
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
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        isDense: true,
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
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
                    //     SizedBox(
                    //
                    //   height: error==false ?20:0,
                    // ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      autofillHints: [AutofillHints.email],
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value!))
                          return 'Enter a valid email';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        isDense: true,
                        labelText: "Email*",
                        errorText: error == false ? null : '',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Gender'),

                    //     ListTile(
                    //       contentPadding:
                    //           EdgeInsets.all(0), //change for side padding
                    //       title: Row(
                    //         children: <Widget>[
                    //           Expanded(
                    //             child: OutlinedButton(
                    //               style: OutlinedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.only(
                    //                       topLeft: Radius.circular(5.0),
                    //                       bottomLeft: Radius.circular(5.0),
                    //                     ),
                    //                   ),
                    //                   primary: Colors.grey,
                    //                   backgroundColor: Colors.white,
                    //                   onSurface: Colors.orangeAccent,
                    //                   // side: BorderSide(color: Colors.deepOrange, width: 1),

                    //                   padding:
                    //                       EdgeInsets.only(top: 15, bottom: 15)),
                    //               onPressed: () {
                    //                 setState(() {
                    //                   gender = '1';
                    //                 });
                    //               },
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   gender == '1'
                    //                       ? Icon(Icons.done,
                    //                           color: Color.fromRGBO(
                    //                               241, 164, 0, 1),
                    //                           size: 20)
                    //                       : Container(),
                    //                   gender == '1'
                    //                       ? SizedBox(width: 5)
                    //                       : Container(),
                    //                   Text("MALE",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.normal,
                    //                           color: gender == '1'
                    //                               ? Theme.of(context)
                    //                                   .primaryColor
                    //                               : Colors.grey)),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             child: OutlinedButton(
                    //               style: OutlinedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(0),
                    //                   ),
                    //                   primary: Colors.grey,
                    //                   backgroundColor: Colors.white,
                    //                   onSurface: Colors.orangeAccent,
                    //                   // side: BorderSide(color: Colors.deepOrange, width: 1),

                    //                   padding:
                    //                       EdgeInsets.only(top: 15, bottom: 15)),
                    //               onPressed: () {
                    //                 setState(() {
                    //                   gender = '2';
                    //                 });
                    //               },
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   gender == '2'
                    //                       ? Icon(Icons.done,
                    //                           color: Color.fromRGBO(
                    //                               241, 164, 0, 1),
                    //                           size: 20)
                    //                       : Container(),
                    //                   gender == '2'
                    //                       ? SizedBox(width: 5)
                    //                       : Container(),
                    //                   Text("FEMALE",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.normal,
                    //                           color: gender == '2'
                    //                               ? Theme.of(context)
                    //                                   .primaryColor
                    //                               : Colors.grey)),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             child: OutlinedButton(
                    //               style: OutlinedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.only(
                    //                       topRight: Radius.circular(5.0),
                    //                       bottomRight: Radius.circular(5.0),
                    //                     ),
                    //                   ),
                    //                   primary: Colors.grey,
                    //                   backgroundColor: Colors.white,
                    //                   onSurface: Colors.orangeAccent,
                    //                   // side: BorderSide(color: Colors.deepOrange, width: 1),

                    //                   padding:
                    //                       EdgeInsets.only(top: 15, bottom: 15)),
                    //               onPressed: () {
                    //                 setState(() {
                    //                   gender = '3';
                    //                 });
                    //               },
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   gender == '3'
                    //                       ? Icon(Icons.done,
                    //                           color: Color.fromRGBO(
                    //                               241, 164, 0, 1),
                    //                           size: 20)
                    //                       : Container(),
                    //                   gender == '3'
                    //                       ? SizedBox(width: 5)
                    //                       : Container(),
                    //                   Text("OTHER",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.normal,
                    //                           color: gender == '3'
                    //                               ? Theme.of(context)
                    //                                   .primaryColor
                    //                               : Colors.grey)),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.datetime,
                    //   controller: _dob,
                    //   autocorrect: false,
                    //   enableInteractiveSelection: false,
                    //   onTap: () async {
                    //     DateTime date = DateTime(1900);
                    //     FocusScope.of(context).requestFocus(new FocusNode());

                    //     date = (await showDatePicker(
                    //         initialEntryMode: DatePickerEntryMode.calendarOnly,
                    //         context: context,
                    //         initialDate: DateTime(
                    //             int.parse(DateFormat('yyyy')
                    //                     .format(DateTime.now())) -
                    //                 18,
                    //             int.parse(
                    //                 DateFormat('MM').format(DateTime.now())),
                    //             int.parse(
                    //                 DateFormat('dd').format(DateTime.now()))),
                    //         firstDate: DateTime(1900),
                    //         lastDate: DateTime(
                    //             int.parse(DateFormat('yyyy')
                    //                     .format(DateTime.now())) -
                    //                 18,
                    //             int.parse(
                    //                 DateFormat('MM').format(DateTime.now())),
                    //             int.parse(DateFormat('dd')
                    //                 .format(DateTime.now())))))!;

                    //     _dob.text = DateFormat('dd-MM-yyyy').format(date);
                    //   },
                    //   decoration: InputDecoration(
                    //     suffixIcon: Icon(Icons.date_range),
                    //     labelStyle:
                    //         TextStyle(color: Theme.of(context).primaryColor),
                    //     isDense: true,
                    //     labelText: "Date Of Birth",
                    //     errorText: error == false ? null : '',
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Theme.of(context).primaryColor),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Theme.of(context).primaryColor),
                    //     ),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: error == false ? 20 : 0,
                    // ),

                    // DropdownButtonFormField(
                    //   decoration: InputDecoration(
                    //     labelStyle:
                    //         TextStyle(color: Theme.of(context).primaryColor),
                    //     isDense: true,
                    //     labelText: "Marital Status",
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                    //     ),
                    //     border: OutlineInputBorder(),
                    //     hintStyle: TextStyle(color: Colors.grey[800]),
                    //   ),
                    //   value: dropDownValue,
                    //   onChanged: (Value) {
                    //     setState(() {
                    //       dropDownValue = Value;
                    //     });
                    //   },
                    //   items: cityList
                    //       .map((cityTitle) => DropdownMenuItem(
                    //           value: cityTitle, child: Text("$cityTitle")))
                    //       .toList(),
                    // ),
                    // SizedBox(
                    //   height: error == false ? 20 : 0,
                    // ),
                    // dropDownValue == 'Married'
                    //     ? TextFormField(
                    //         keyboardType: TextInputType.datetime,
                    //         controller: _aniversity,
                    //         autocorrect: false,
                    //         enableInteractiveSelection: false,
                    //         onTap: () async {
                    //           DateTime date = DateTime(1900);
                    //           FocusScope.of(context)
                    //               .requestFocus(new FocusNode());

                    //           date = (await showDatePicker(
                    //               initialEntryMode:
                    //                   DatePickerEntryMode.calendarOnly,
                    //               context: context,
                    //               initialDate: DateTime.now(),
                    //               firstDate: DateTime(1900),
                    //               lastDate: DateTime.now()))!;

                    //           _aniversity.text =
                    //               DateFormat('dd-MM-yyyy').format(date);
                    //         },
                    //         decoration: InputDecoration(
                    //           suffixIcon: Icon(Icons.date_range),
                    //           labelStyle: TextStyle(
                    //               color: Theme.of(context).primaryColor),
                    //           isDense: true,
                    //           labelText: "Anniversary Date",
                    //           errorText: error == false ? null : '',
                    //           enabledBorder: OutlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Theme.of(context).primaryColor),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Theme.of(context).primaryColor),
                    //           ),
                    //           border: OutlineInputBorder(),
                    //         ),
                    //       )
                    //     : SizedBox(),
                    // SizedBox(
                    //   height: dropDownValue == 'Married' ? 20 : 0,
                    // ),

                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   controller: _refferal,
                    //   decoration: InputDecoration(
                    //     labelStyle:
                    //         TextStyle(color: Theme.of(context).primaryColor),
                    //     isDense: true,
                    //     labelText: "Referral Code",
                    //     errorText: error == false ? null : '',
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Color.fromRGBO(24, 56, 113, 1)),
                    //     ),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: error == false ? 20 : 0,
                    // ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(24, 56, 113, 1)),
                        // minimumSize: MaterialStateProperty.all(MediaQuery.of(context).size.width, 50),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/4, 15,MediaQuery.of(context).size.width/4, 15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                    // background
                    // foreground
                    onPressed: () async {
                      // verifyUserPhoneNumber();

                      // Validate returns true if the form is valid, or false otherwise.

                      if (_formKey.currentState!.validate()) {
                        var ApiService =
                            Provider.of<ApiServices>(context, listen: false);
                        ApiService.Register(
                                _fullname.text, _email.text, _phone.text)
                            .then((el) {
                          print("sucess${el}");
                          // Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) => new OtpVerify()));
                        }).catchError((err) {
                          print("err${err}");
                          // Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) => new OtpVerify()));
                        });
                        print("test");
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.

                        //   store.set("email", _email.text);
                        //   store.set("phone", _phone.text);
                        //   store.set("dob", _dob.text);
                        //   store.set("aniversity", _aniversity.text);
                        //   if(dropDownValue=='Married'){
                        //     store.set("maritalStatus",'1');
                        //   }
                        //   else if(dropDownValue=='Unmarried'){
                        //     store.set("maritalStatus", '2');
                        //   }
                        //   else {
                        //     store.set("maritalStatus", '0');
                        //   }

                        //   store.set("gender", gender);
                        //   store.set("fullname", _fullname.text);
                        //   if( _refferal.text=="" ||  _refferal.text ==null){
                        //     store.set("referral", "");
                        //   }
                        //   else{
                        //     store.set("referral", _refferal.text);
                        //   }
                        //   // Navigator.push(context, new MaterialPageRoute(builder: (context) => new OtpVerify()));

                        //   await _sayHello();
                        //   // ScaffoldMessenger.of(context)
                        //   //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Alerady Have an Account ?',
                              style: TextStyle(
                                color: Color.fromRGBO(24, 56, 113, 1),
                              ))),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // Future<void> _sayHello() async {
  //   await EasyLoading.show(
  //     status: 'loading...',
  //     maskType: EasyLoadingMaskType.custom,

  //   );
  //   await HometruckGrpc.sendMessage().then((responseData) {
  //     print(responseData);
  //     if(responseData.successCode==406){
  //       _timer?.cancel();
  //       EasyLoading.dismiss();
  //       setState((){
  //         phoneError=true;
  //         phoneErrorMsg=responseData.successMsg;
  //       });
  //     }
  //     else{
  //       store.set("userID", responseData.userID);
  //       _timer?.cancel();
  //       EasyLoading.dismiss();
  //       Navigator.push(context, new MaterialPageRoute(builder: (context) => new OtpVerify()));
  //     }


  //   }).catchError((err){
  //     print(err);
  //     _timer?.cancel();
  //     EasyLoading.dismiss();
  //   });


  //   // setState(() {
  //   //   res = hello.response;
  //   // });
  // }
  // }