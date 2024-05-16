import 'package:crossplatform/customDrawer.dart';
import 'package:crossplatform/logsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget currentPage = LogsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cross Platform Application'),
      ),
      body: currentPage,
      drawer: CustomDrawer(onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
        Navigator.pop(context); // Close the drawer
      }),
    );
  }
}
