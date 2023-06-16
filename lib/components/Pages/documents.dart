import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';

/// Flutter code sample for [SliverAppBar].

class CustomerDocuments extends StatefulWidget {
  const CustomerDocuments({super.key});

  @override
  State<CustomerDocuments> createState() => _CustomerDocumentsState();
}

enum SingingCharacter { yes, no }

class _CustomerDocumentsState extends State<CustomerDocuments> {
  FilePickerResult? aadhar_file;
  FilePickerResult? pan_file;
  FilePickerResult? photo_file;
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
                              Text("Upload Documents",
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
                                        value: 75,
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
                                            '3/4',
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

                          padding: EdgeInsets.symmetric(horizontal: 20),

                          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                          /// Use [Axis.vertical] to scroll vertically.

                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Aadhar Card",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        aadhar_file = await FilePicker.platform
                                            .pickFiles(allowMultiple: false);
                                        if (aadhar_file == null) {
                                          print("No file selected");
                                        } else {
                                          setState(() {});
                                          aadhar_file?.files.forEach((element) {
                                            print(element.name);
                                          });
                                        }
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(12),
                                        padding: EdgeInsets.all(6),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.64,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(aadhar_file == null
                                                  ? "Upload Here.."
                                                  : "${aadhar_file?.files[0].name}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              Color.fromRGBO(24, 56, 113, 1)),
                                      child: IconButton(
                                        icon: const Icon(Icons.upload),
                                        tooltip: 'Increase volume by 10',
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Pan Card",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        pan_file = await FilePicker.platform
                                            .pickFiles(allowMultiple: false);
                                        if (pan_file == null) {
                                          print("No file selected");
                                        } else {
                                          setState(() {});
                                          pan_file?.files.forEach((element) {
                                            print(element.name);
                                          });
                                        }
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(12),
                                        padding: EdgeInsets.all(6),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.64,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(pan_file == null
                                                  ? "Upload Here.."
                                                  : "${pan_file?.files[0].name}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              Color.fromRGBO(24, 56, 113, 1)),
                                      child: IconButton(
                                        icon: const Icon(Icons.upload),
                                        tooltip: 'Increase volume by 10',
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Passport Photo",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        photo_file = await FilePicker.platform
                                            .pickFiles(allowMultiple: false);
                                        if (pan_file == null) {
                                          print("No file selected");
                                        } else {
                                          setState(() {});
                                          photo_file?.files.forEach((element) {
                                            print(element.name);
                                          });
                                        }
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(12),
                                        padding: EdgeInsets.all(6),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.64,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(photo_file == null
                                                  ? "Upload Here.."
                                                  : "${photo_file?.files[0].name}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              Color.fromRGBO(24, 56, 113, 1)),
                                      child: IconButton(
                                        icon: const Icon(Icons.upload),
                                        tooltip: 'Increase volume by 10',
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
