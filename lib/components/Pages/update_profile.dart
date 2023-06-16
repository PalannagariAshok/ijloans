import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'documents.dart';

/// Flutter code sample for [SliverAppBar].

class CustomerUpdateProfile extends StatefulWidget {
  const CustomerUpdateProfile({super.key});

  @override
  State<CustomerUpdateProfile> createState() => _CustomerUpdateProfileState();
}

enum SingingCharacter { yes, no }

class _CustomerUpdateProfileState extends State<CustomerUpdateProfile> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  var error = false;
  var selected_bank;
  var selected_builder;
  var selected_income;

  late TextEditingController customer_name;

  late TextEditingController house_no;
  late TextEditingController locality;
  late TextEditingController city;
  late TextEditingController pincode;
  late TextEditingController state;
  var receivedID = '';
  String gender = '';
  late TextEditingController _phone;
  String phoneErrorMsg = '';
  bool phoneError = false;
  final _formKey = GlobalKey<FormState>();
  int selectedRadio = 0;
  SingingCharacter? _character = SingingCharacter.yes;
  List<String> income_list = [
    'Salaried',
    'Self Employed - NP',
    'Professionals',
    'Others'
  ];

  @override
  void initState() {
    super.initState();

    house_no = TextEditingController();
    customer_name = TextEditingController();
    locality = TextEditingController();
    city = TextEditingController();
    state = TextEditingController();
    pincode = TextEditingController();
  }

  @override
  void dispose() {
    customer_name.dispose();
    house_no.dispose();
    locality.dispose();
    city.dispose();
    state.dispose();
    pincode.dispose();
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
                              Text("Profile Details",
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
                                        value: 50,
                                        width: 0.20,
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
                                            '2/4',
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
                            Text(
                              "Option to choose",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: SingingCharacter.yes,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                    Text("Primary"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: SingingCharacter.no,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                    Text("Co-applicant"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: customer_name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Customer Name",
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
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Select Income Category",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 56, 113, 1)),
                                ),
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.grey[800]),
                              ),
                              value: selected_income,
                              onChanged: (Value) {
                                setState(() {
                                  selected_bank = Value;
                                });
                              },
                              items: income_list
                                  .map((cityTitle) => DropdownMenuItem(
                                      value: cityTitle,
                                      child: Text("$cityTitle")))
                                  .toList(),
                            ),
                            SizedBox(
                              height: error == false ? 20 : 0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: house_no,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Flat/House No.';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Enter Flat/House No.",
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
                              controller: locality,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Locality or Area';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Enter Locality or Area",
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
                              controller: city,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter City';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Enter City",
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
                              controller: pincode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Pincode';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Enter Pincode",
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
                              controller: state,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter State';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Enter State",
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
                                            new CustomerDocuments()));
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
