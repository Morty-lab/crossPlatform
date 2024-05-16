import 'package:crossplatform/textToSpeech.dart';
import 'package:flutter/material.dart';

import 'fileUploading.dart';
import 'logsPage.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<Widget> onPageChanged;

  const CustomDrawer({Key? key, required this.onPageChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "Cross Platform Application",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Logs'),
            onTap: () {
              onPageChanged(LogsPage());
            },
          ),
          ListTile(
            title: Text('File Uploading'),
            onTap: () {
              onPageChanged(FileUploadingPage());
            },
          ),
          ListTile(
            title: Text('Text to Speech'),
            onTap: () {
              onPageChanged(TextToSpeech());
            },
          ),
        ],
      ),
    );
  }
}
