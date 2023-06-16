import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ijloans/providers/ApiServices.dart';
// import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;
  late String lastLoggedIn;
  late String imgPath;
  bool loading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  getProfileData() async {
    final SharedPreferences prefs = await _prefs;
    var ApiService = await Provider.of<ApiServices>(context, listen: false);

    ApiService.UserProfile(prefs.getString('phone')).then((el) {
      setState(() {
        loading = true;
      });
    });
  }

  bool _enabled = true;

  // final StreamController _streamController = CategoryGrpc.listenForCategory() as StreamController;

  void initState() {
    //sendMessages();

    super.initState();
    getProfileData();

    // client.sendMessages().then((vaal)=>{
    //   print(vaal)
    // });
  }

  double _collapsedHeight = 60;
  double _expandedHeight = 150;
  int addressClick = 0;
  late double
      extentRatio; // Value to control SliverAppBar widget sizes, based on BoxConstraints and
  double minH1 = 40; // Minimum height of the first image.
  double minW1 = 40; // Minimum width of the first image.
  double minH2 = 20; // Minimum height of second image.
  double minW2 = 25; // Minimum width of second image.
  double maxH1 = 60; // Maximum height of the first image.
  double maxW1 = 60; // Maximum width of the first image.
  double maxH2 = 40; // Maximum height of second image.
  double maxW2 = 50; // Maximum width of second image.
  double textWidth = 70; // Width of a given title text.
  double extYAxisOff = 10.0;
  dialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: Container(
                height: 100,
                width: 500,
                alignment: Alignment.center,
                child: Text('Server Unavailable')),
          );
        });
  } // Offset on Y axis for both images when sliver is extended.

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;

    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
            child: loading
                ? NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            collapsedHeight: _collapsedHeight,
                            expandedHeight: _expandedHeight,
                            floating: true,
                            pinned: true,
                            // title:Text('hi'),
                            flexibleSpace: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                var respHeight = constraints.biggest.height;
                                extentRatio = (constraints.biggest.height -
                                        _collapsedHeight) /
                                    (_expandedHeight - _collapsedHeight);
                                double xAxisOffset1 = ((minW1 - minW2) -
                                        (textWidth + maxW1) * extentRatio) /
                                    2;
                                double xAxisOffset2 = (-(minW1 - minW2) +
                                        textWidth +
                                        (-textWidth - maxW2) * extentRatio) /
                                    2;
                                double yAxisOffset2 = (-(minH1 - minH2) -
                                            (maxH1 - maxH2 - (minH1 - minH2)) *
                                                extentRatio) /
                                        10 -
                                    extYAxisOff * (extentRatio);
                                double yAxisOffset1 =
                                    -extYAxisOff * extentRatio;
                                // print(extYAxisOff);
                                // debugPrint('constraints=' + constraints.toString());
                                // debugPrint('Scale ratio is $extentRatio');
                                return FlexibleSpaceBar(
                                  titlePadding: EdgeInsets.all(0),
                                  // centerTitle: true,
                                  title: AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity: 1.0,
                                    // margin:EdgeInsets.all(30),
                                    // alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () async {},

                                      // decoration: BoxDecoration(
                                      //   border: Border.all(width:1,color:Colors.black),
                                      // ),

                                      // alignment: Alignment.center,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    // color:Colors.red,
                                                    width: textWidth,
                                                    height: double.infinity,
                                                    margin: EdgeInsets.only(
                                                        bottom: respHeight / 7,
                                                        left: 10),

                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: minW1 +
                                                              (maxW1 - minW1) *
                                                                  extentRatio,
                                                          height: minH1 +
                                                              (maxH1 - minH1) *
                                                                  extentRatio,
                                                          // margin:respHeight < 80.0? EdgeInsets.only(top:0,left:20):EdgeInsets.only(top:40,left:20),

                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            // border: Border.all(width:2,color:Colors.amber),
                                                            // color: Colors.red,
                                                          ),
                                                          // child:Image.asset('assets/profile.png',
                                                          //   fit:BoxFit.fitHeight,
                                                          // ),
                                                          // child:Image.network(imgPath,fit:BoxFit.fitHeight,
                                                          child: Consumer<
                                                                  ApiServices>(
                                                              builder: (_,
                                                                  profileImages,
                                                                  ch) {
                                                            return CircleAvatar(
                                                              radius: 65,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,

                                                              //backgroundImage: NetworkImage('${config().urlFileImage}${validationProfileService.imgPath}'),
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
                                                            );
                                                          })),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Consumer<ApiServices>(
                                              builder: (_, profile, ch) {
                                            return Container(
                                              // width:MediaQuery.of(context).size.width,
                                              // color:Colors.red,

                                              child: Stack(
                                                children: [
                                                  Container(
                                                    // color:Colors.green,
                                                    width: respHeight < 80.0
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,

                                                    height: double.infinity,
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            respHeight / 3.3,
                                                        left: 10),

                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          // width:respHeight < 80.0?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/3,
                                                          child: Text(
                                                            '${profile.profileData['username']}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      241,
                                                                      164,
                                                                      0,
                                                                      1),
                                                              fontSize:
                                                                  respHeight <
                                                                          80.0
                                                                      ? 20.0
                                                                      : 18.0,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.edit,
                                                            color: Colors
                                                                .grey[300],
                                                            size: 10),
                                                      ],
                                                    ),
                                                  ),
                                                  AnimatedOpacity(
                                                      opacity:
                                                          respHeight < 140.0
                                                              ? 0
                                                              : 1.0,
                                                      duration: Duration(
                                                          milliseconds: 200),
                                                      child: Container(
                                                        // color:Colors.red,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                        height: double.infinity,
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        margin: EdgeInsets.only(
                                                            bottom: respHeight /
                                                                5.5,
                                                            left: 10),
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              // width:respHeight < 80.0?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/3,
                                                              child: Text(
                                                                '${profile.profileData['email']}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // background: ,
                                );
                              },
                            )),
                      ];
                    },
                    body: Container(
                        color: Colors.grey[100],
                        child: ListView(
                          children: [
                            Card(
                              child: ListTile(
                                onTap: () async {},
                                leading: Container(
                                    child: Icon(Icons.payments,
                                        color: Color.fromRGBO(241, 164, 0, 1))),
                                title: Text('Loan Status'),
                                subtitle: Text('Check your Loan status'),
                                trailing: Icon(Icons.navigate_next),
                              ),
                            ),

                            Card(
                              child: ListTile(
                                onTap: () async {
                                  // print(AllAddressList.allAddress.length);
                                },
                                leading: Container(
                                    child: Icon(Icons.upload_file,
                                        color: Color.fromRGBO(241, 164, 0, 1))),
                                title: Text('Documents'),
                                subtitle: Text('Check your documents'),
                                trailing: Icon(Icons.navigate_next),
                              ),
                            ),
                            // Card(
                            //   child: ListTile(
                            //     onTap: ()async {
                            //       await EasyLoading.show(
                            //         status: 'loading...',
                            //         maskType: EasyLoadingMaskType.custom,
                            //
                            //       );
                            //      await wallet.viewWallet().then((value) {
                            //        EasyLoading.dismiss();
                            //        Navigator.of(context).push(
                            //          CupertinoPageRoute(builder: (context) => const add_wallet()),
                            //          // MaterialPageRoute(builder: (context) => AddAddress()),
                            //        );
                            //      }).onError((error, stackTrace) {
                            //        EasyLoading.dismiss();
                            //      });
                            //
                            //     },
                            //     leading:
                            //     Container(
                            //
                            //         child: Icon(Icons.account_balance_wallet,color:Color.fromRGBO(241, 164, 0, 1))),
                            //     title: Text('Wallet'),
                            //     subtitle:
                            //     Text('View and add amount to your HT Wallet'),
                            //     trailing: Icon(Icons.navigate_next),
                            //
                            //   ),
                            //
                            // ),
                            // Card(
                            //   child: ListTile(
                            //     leading:
                            //     Container(
                            //
                            //         child: Icon(Icons.card_membership,color:Color.fromRGBO(241, 164, 0, 1))),
                            //     title: Text('Membership'),
                            //     subtitle:
                            //     Text('View and Upgrade your Membership'),
                            //     trailing: Icon(Icons.navigate_next),
                            //
                            //   ),
                            //
                            // ),
                            // Card(
                            //   child: ListTile(
                            //     leading:
                            //     Container(
                            //
                            //         child: Icon(Icons.share,color:Color.fromRGBO(241, 164, 0, 1))),
                            //     title: Text('Referral Code'),
                            //     subtitle:
                            //     Text('Invite friends & earn rewards'),
                            //     trailing: Icon(Icons.navigate_next),
                            //
                            //   ),
                            //
                            // ),
                            SizedBox(height: 15),
                            Container(
                                height: MediaQuery.of(context).size.height / 7,
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 5.2,
                                    top: 10,
                                    bottom: 10),
                                color: Colors.white,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Text('FAQs',style:TextStyle(fontSize:18,color:Theme.of(context).primaryColor)),
                                      Text('About Us',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      //Text('Terms of Use',style:TextStyle(fontSize:18,color:Theme.of(context).primaryColor)),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Text('Privacy Policy | T&C',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor))),
                                    ])),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () async {},
                                child: Text('Log Out',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ],
                        )))
                : Container()),
      ),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}













//
// class Profile extends StatefulWidget {
//
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   // late final CategoryGrpc client;
//   static HTCategoryClient? getCategoryClient(){
//
//     late final client = HTCategoryClient(ClientChannel(
//       "128.199.29.38",
//       port: 3000,
//       options: ChannelOptions(
//         credentials: ChannelCredentials.insecure(),
//
//
//       ),
//
//     ));
//     return client;
//   }
//   final categoryReqs = categoryReq( )..type='testCategory';
//    sendMessages() async {
//     categoryListResp data;
//
//
//     await getCategoryClient()!.categoryList(categoryReqs).listen((value) {
//       data=value;
//       print(value);
//     });
//
//   }
//
//   // final StreamController _streamController = CategoryGrpc.listenForCategory() as StreamController;
//   void initState() {
//     super.initState();
//     sendMessages();
//     // client.sendMessages().then((vaal)=>{
//     //   print(vaal)
//     // });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final providerToken=Provider.of<Auth>(context);
//     final Home=Provider.of<BottomNav>(context,listen: false);
//
//
//     SharedPreferences prefs;
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text("Profle"),
//         //
//         // ),
//        // body:
//        // ListView(
//        //   children: [
//        //     // StreamBuilder<List<Message>>(
//        //     //   stream: _streamController.stream,
//        //     //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//        //     //     if (snapshot.hasError) {
//        //     //       return Text("Error: ${snapshot.error}");
//        //     //     }
//        //     //     switch (snapshot.connectionState) {
//        //     //       case ConnectionState.none:
//        //     //       case ConnectionState.waiting:
//        //     //         break;
//        //     //       case ConnectionState.active:
//        //     //       case ConnectionState.done:
//        //     //
//        //     //     }
//        //     //     return Text('ok');
//        //     //   },
//        //     // ),
//        //     Container(
//        //       child: ElevatedButton(
//        //         style: ButtonStyle(
//        //             backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
//        //
//        //             // minimumSize: MaterialStateProperty.all(0, 10)),
//        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//        //                 RoundedRectangleBorder(
//        //                   borderRadius: BorderRadius.circular(5.0),
//        //
//        //                 )
//        //             )
//        //         ),
//        //         onPressed: () async =>{
//        //           print('ok'),
//        //          prefs = await SharedPreferences.getInstance(),
//        //           prefs.remove('token'),
//        //           print('${prefs.getString('token')}'),
//        //           if(prefs.getString('token') != null ){
//        //            providerToken.token='${prefs.getString('token')}',
//        //          }
//        //           else{
//        //             providerToken.token='',
//        //           },
//        //
//        //           Navigator.of(context).popUntil(ModalRoute.withName('/')),
//        //           Home.currentIndex=0,
//        //         },
//        //
//        //         child: Padding(
//        //           padding: const EdgeInsets.all(0),
//        //           child: Row(
//        //             children: [
//        //               Icon(Icons.add,color:Colors.white,size:16),
//        //               Text('Log Out',style: TextStyle(color:Colors.white,fontSize:12),),
//        //             ],
//        //           ), //Row
//        //         ), //Padding
//        //       ),
//        //     ),
//        //   ],
//        // )
//       body:NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               snap: true,
//               floating: true,
//
//
//               expandedHeight: 1.7 * kToolbarHeight,
//               flexibleSpace:
//               FlexibleSpaceBar(
//                 collapseMode: CollapseMode.pin,
//                 centerTitle: true,
//                 background:Container(
//                   child:Text('profile')
//                 )
//
//
//               ),
//             ),
//           ];
//         },
//         body:
//         ListView(
//           children: [
//
//
//
//             // horizontalList1(),
//             Container(
//               padding:EdgeInsets.symmetric(horizontal: 20),
//               margin:EdgeInsets.only(top:10),
//
//               child:
//               Text("Top Savers Today",
//                 style:TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromRGBO(24, 56, 113, 1)
//                 ),
//               ),
//
//             ),
//
//             Container(
//               width:MediaQuery.of(context).size.width,
//
//               child:Image.asset('assets/discount.png',width:MediaQuery.of(context).size.width,),
//
//             ),
//             Container(
//               color:Color.fromRGBO(241, 164, 0, 1),
//               margin:EdgeInsets.symmetric(vertical: 10),
//               child: Column(
//                 children: [
//                   Container(
//                     width:double.infinity,
//                     padding:EdgeInsets.only(top:10,left:15),
//
//                     child:
//                     Text("Summer Savings"
//                       ,textAlign: TextAlign.left,
//                       style:TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromRGBO(24, 56, 113, 1)
//                       ),
//                     ),
//
//                   ),
//                   GridView(
//                     children: <Widget>[
//                       Card(
//                         elevation: 2,
//                         shadowColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: SizedBox(
//
//
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:double.infinity,
//                                     height:MediaQuery.of(context).size.height/ 15,
//                                     alignment:Alignment.center,
//                                     child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text('Flat',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                           Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                               children:[
//
//                                                 Text('50%',style:TextStyle(color:Color.fromRGBO(241, 164, 0, 1),fontSize:16,fontWeight:FontWeight.bold)),
//                                                 Text('Offer',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                               ]
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child:Image.asset('assets/oil.png',
//                                       height: MediaQuery.of(context).size.height/ 10,),
//                                   ),
//
//
//                                 ])
//
//                         ),
//                       ),
//                       Card(
//                         elevation: 2,
//                         shadowColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: SizedBox(
//
//
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:double.infinity,
//                                     height:MediaQuery.of(context).size.height/ 15,
//                                     alignment:Alignment.center,
//                                     child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text('Flat',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                           Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                               children:[
//
//                                                 Text('50%',style:TextStyle(color:Color.fromRGBO(241, 164, 0, 1),fontSize:16,fontWeight:FontWeight.bold)),
//                                                 Text('Offer',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                               ]
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child:Image.asset('assets/oil.png',
//                                       height: MediaQuery.of(context).size.height/ 10,),
//                                   ),
//
//
//                                 ])
//
//                         ),
//                       ),
//                       Card(
//                         elevation: 2,
//                         shadowColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: SizedBox(
//
//
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:double.infinity,
//                                     height:MediaQuery.of(context).size.height/ 15,
//                                     alignment:Alignment.center,
//                                     child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text('Flat',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                           Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                               children:[
//
//                                                 Text('50%',style:TextStyle(color:Color.fromRGBO(241, 164, 0, 1),fontSize:16,fontWeight:FontWeight.bold)),
//                                                 Text('Offer',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                               ]
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child:Image.asset('assets/oil.png',
//                                       height: MediaQuery.of(context).size.height/ 10,),
//                                   ),
//
//
//                                 ])
//
//                         ),
//                       ),
//                       Card(
//                         elevation: 2,
//                         shadowColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: SizedBox(
//
//
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:double.infinity,
//                                     height:MediaQuery.of(context).size.height/ 15,
//                                     alignment:Alignment.center,
//                                     child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text('Flat',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                           Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                               children:[
//
//                                                 Text('50%',style:TextStyle(color:Color.fromRGBO(241, 164, 0, 1),fontSize:16,fontWeight:FontWeight.bold)),
//                                                 Text('Offer',style:TextStyle(color:Theme.of(context).primaryColor,fontSize:16,fontWeight:FontWeight.bold)),
//                                               ]
//                                           )
//                                         ]
//                                     ),
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child:Image.asset('assets/oil.png',
//                                       height: MediaQuery.of(context).size.height/ 10,),
//                                   ),
//
//
//                                 ])
//
//                         ),
//                       ),
//
//
//                     ],
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: ((MediaQuery.of(context).size.width/ 4) / (MediaQuery.of(context).size.height/ 6.2)),
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       crossAxisCount: 3,
//                     ),
//                     physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
//                     shrinkWrap: true,
//                     primary: false,
//                     padding: const EdgeInsets.all(20),
//                   )
//                 ],
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//
//   }
// }
