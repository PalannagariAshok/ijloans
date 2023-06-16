import 'package:flutter/material.dart';
import 'package:ijloans/components/Pages/LandingPage.dart';
import 'package:ijloans/providers/ApiServices.dart';

import 'components/Auth/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<dynamic> login;
  String LoginData = "";
  var success;
  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    print("ssuccessssssss ${prefs.getBool("success")}");
    setState(() {
      login = _prefs.then((SharedPreferences prefs) {
        return prefs.getString('login') ?? "null";
      });
      success = prefs.getBool("success");
      LoginData = prefs.getString('login') ?? "null";
    });
    print(prefs.getString('login'));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ApiServices(),
          ),
        ],
        child: FutureBuilder<dynamic>(
            future: login,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    print("edjkdkj${LoginData}");
                    return MaterialApp(
                      title: 'EvRides Driver',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        // This is the theme of your application.
                        //
                        // Try running your application with "flutter run". You'll see the
                        // application has a blue toolbar. Then, without quitting the app, try
                        // changing the primarySwatch below to Colors.green and then invoke
                        // "hot reload" (press "r" in the console where you ran "flutter run",
                        // or simply save your changes to "hot reload" in a Flutter IDE).
                        // Notice that the counter didn't reset back to zero; the application
                        // is not restarted.
                        // primarySwatch: Colors.amber,
                        appBarTheme: AppBarTheme(
                          backgroundColor: Color.fromRGBO(24, 56, 113, 1),
                        ),
                        primaryColor: Color.fromRGBO(24, 56, 113, 1),
                      ),
                      initialRoute: LoginData == "null" ? '/login' : "/",
                      routes: {
                        // When navigating to the "/" route, build the FirstScreen widget.
                        '/': (context) => LandingPage(),
                        // When navigating to the "/second" route, build the SecondScreen widget.
                        '/login': (context) => SignUpButton(),
                      },

                      // home: LoginScreen(),
                    );
                  }
              }
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SignUpButton();
  }
}
