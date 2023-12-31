import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'customer_property.dart';

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

  late TextEditingController aadhar_no;
  late TextEditingController pan_no;
  late TextEditingController cibil_score;
  late TextEditingController montly_income;
  late TextEditingController loan_amount;
  late TextEditingController loan_tenure;
  var receivedID = '';
  String gender = '';
  late TextEditingController _phone;
  String phoneErrorMsg = '';
  bool phoneError = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    aadhar_no = TextEditingController();
    pan_no = TextEditingController();
    // _dob = TextEditingController();
    cibil_score = TextEditingController();
    montly_income = TextEditingController();
    loan_amount = TextEditingController();
    loan_tenure = TextEditingController();
    // _pincode = TextEditingController();
    // _refferal = TextEditingController();
    // _aniversity = TextEditingController();
  }

  @override
  void dispose() {
    aadhar_no.dispose();
    pan_no.dispose();
    // _aniversity.dispose();
    cibil_score.dispose();
    montly_income.dispose();
    loan_amount.dispose();
    loan_tenure.dispose();
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
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, Let Get Started",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300)),
                              Text("KYC Details",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: 0,
                                    maximum: 100,
                                    showLabels: false,
                                    showTicks: false,
                                    startAngle: 270,
                                    endAngle: 270,
                                    // axisLineStyle: AxisLineStyle(
                                    //   thickness: 1,
                                    //   // color: const Color.fromARGB(255, 0, 169, 181),
                                    //   thicknessUnit: GaugeSizeUnit.factor,
                                    // ),
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: 0,
                                        width: 0.15,
                                        color: Color.fromRGBO(24, 56, 113, 1),
                                        // pointerOffset: 0.1,
                                        cornerStyle: CornerStyle.bothCurve,
                                        sizeUnit: GaugeSizeUnit.factor,
                                      )
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          positionFactor: 0.1,
                                          angle: 90,
                                          widget: Text(
                                            '0/4',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Color.fromRGBO(
                                                    24, 56, 113, 1)),
                                          ))
                                    ])
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              //set border radius more than 50% of height and width to make circle
            ),
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
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: aadhar_no,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Aadhar';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Aadhar Number",
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
                              keyboardType: TextInputType.text,
                              controller: pan_no,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Pan';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Pan Number",
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
                              keyboardType: TextInputType.text,
                              controller: cibil_score,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter CIBIL';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "CIBIL Score",
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
                              keyboardType: TextInputType.text,
                              controller: montly_income,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Montly Income';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Montly Income",
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
                              keyboardType: TextInputType.text,
                              controller: loan_amount,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Loan Amount';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Loan Amount",
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
                              keyboardType: TextInputType.text,
                              controller: loan_tenure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Loan Tenure';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Loan Tenure",
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
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new CustomerProperty()));
                                if (_formKey.currentState!.validate()) {}
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
