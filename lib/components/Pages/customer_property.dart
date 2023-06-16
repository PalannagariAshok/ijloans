import 'package:flutter/material.dart';
import 'package:ijloans/components/Pages/update_profile.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Flutter code sample for [SliverAppBar].

class CustomerProperty extends StatefulWidget {
  const CustomerProperty({super.key});

  @override
  State<CustomerProperty> createState() => _CustomerPropertyState();
}

enum SingingCharacter { yes, no }

class _CustomerPropertyState extends State<CustomerProperty> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  var error = false;
  var selected_bank;
  var selected_builder;
  var selected_project;

  late TextEditingController property_location;

  late TextEditingController bank_branch;
  late TextEditingController other_builder_name;
  var receivedID = '';
  String gender = '';
  late TextEditingController _phone;
  String phoneErrorMsg = '';
  bool phoneError = false;
  final _formKey = GlobalKey<FormState>();
  int selectedRadio = 0;
  SingingCharacter? _character = SingingCharacter.yes;
  List<String> bank_name = ['SBI', 'HDFI'];
  List<String> builder_list = ['Test', 'Other'];
  List<String> project_list = ['Test', 'Other'];
  @override
  void initState() {
    super.initState();

    property_location = TextEditingController();
    bank_branch = TextEditingController();
    other_builder_name = TextEditingController();
    // _pincode = TextEditingController();
    // _refferal = TextEditingController();
    // _aniversity = TextEditingController();
  }

  @override
  void dispose() {
    property_location.dispose();
    bank_branch.dispose();
    other_builder_name.dispose();
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
                              Text("Property Details",
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
                                        value: 25,
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
                                            '1/4',
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
                              "Property Selected",
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
                                    Text("Yes"),
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
                                    Text("No"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Select Builder",
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
                              value: selected_builder,
                              onChanged: (Value) {
                                setState(() {
                                  selected_builder = Value;
                                });
                              },
                              items: builder_list
                                  .map((cityTitle) => DropdownMenuItem(
                                      value: cityTitle,
                                      child: Text("$cityTitle")))
                                  .toList(),
                            ),
                            selected_builder == "Other"
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: other_builder_name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Builder Name';
                                          } else if (value.length < 4) {
                                            return 'Please Enter Min 4 Char';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          isDense: true,
                                          labelText: "Builder Name",
                                          errorText: error == false ? null : '',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    24, 56, 113, 1)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    24, 56, 113, 1)),
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: error == false ? 20 : 0,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Select Project",
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
                              value: selected_project,
                              onChanged: (Value) {
                                setState(() {
                                  selected_builder = Value;
                                });
                              },
                              items: project_list
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
                              controller: property_location,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Project Location';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Project Location",
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
                                labelText: "Select Bank",
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
                              value: selected_bank,
                              onChanged: (Value) {
                                setState(() {
                                  selected_bank = Value;
                                });
                              },
                              items: bank_name
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
                              controller: bank_branch,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Bank Branch';
                                } else if (value.length < 4) {
                                  return 'Please Enter Min 4 Char';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                isDense: true,
                                labelText: "Bank Branch",
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
                                            new CustomerUpdateProfile()));
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
