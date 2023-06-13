import 'package:flutter/material.dart';

/// Flutter code sample for [SliverAppBar].

class CustomerKyc extends StatefulWidget {
  const CustomerKyc({super.key});

  @override
  State<CustomerKyc> createState() => _CustomerKycState();
}

class _CustomerKycState extends State<CustomerKyc> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  var error = false;
  late TextEditingController _email;

  late TextEditingController _fullname;
  late TextEditingController _dob;
  late TextEditingController _aniversity;
  late TextEditingController _pincode;
  late TextEditingController _refferal;
  late TextEditingController otpController;
  var receivedID = '';
  String gender = '';
  late TextEditingController _phone;
  String phoneErrorMsg = '';
  bool phoneError = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

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

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              // expandedHeight: 160.0,
              title: Text('Home Loan'),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Color.fromARGB(255, 235, 235, 235),
                child: SizedBox(
                  height: 140,
                  child: Center(
                    child: Text('Scroll to see the SliverAppBar in effect.'),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Color.fromARGB(255, 235, 235, 235),
          child: Card(
            elevation: 30,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: Form(
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
                              horizontal:
                                  MediaQuery.of(context).size.width / 10),

                          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                          /// Use [Axis.vertical] to scroll vertically.

                          children: <Widget>[
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
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "FullName*",
                                errorText: error == false ? null : '',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
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
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Text('+91 ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ))),
                                labelText: "Phone Number*",
                                errorText:
                                    phoneError == false ? null : phoneErrorMsg,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
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
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Email*",
                                errorText: error == false ? null : '',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(24, 56, 113, 1)),
                                  minimumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width, 50)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              // background
                              // foreground
                              onPressed: () async {
                                // verifyOTPCode();
                              },
                              child: Text('Save & Continue',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
