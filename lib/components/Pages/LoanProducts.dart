import 'package:flutter/material.dart';

import 'kyc.dart';

class LoanProducts extends StatefulWidget {
  const LoanProducts({super.key});

  @override
  State<LoanProducts> createState() => _LoanProductsState();
}

class _LoanProductsState extends State<LoanProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Loan Products"),
      ),
      body: ListView(children: [
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CustomerKyc()));
            },
            leading: Icon(
              Icons.home,
              size: 60,
              color: Color.fromRGBO(241, 164, 0, 1),
            ),
            title: Text(
              "Home Loan",
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(24, 56, 113, 1)),
            ),
            subtitle: Text('few steps away from getting loan offer'),
            trailing: Icon(Icons.arrow_forward),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 60,
              color: Color.fromRGBO(241, 164, 0, 1),
            ),
            title: Text(
              "Personal Loan",
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(24, 56, 113, 1)),
            ),
            subtitle: Text('few steps away from getting loan offer'),
            trailing: Icon(Icons.arrow_forward),
            isThreeLine: true,
          ),
        ),
      ]),
    );
  }
}
