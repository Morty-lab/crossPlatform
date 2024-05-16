import 'platform.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FileUploadingPage extends StatefulWidget {
  @override
  _FileUploadingPageState createState() => _FileUploadingPageState();
}

// Future<void> _uploadFileAndStoreInfo(PlatformFile file) async {
//   try {
//     uploadFile(file);
//   } catch (e) {
//     print(e);
//   }
// }

class _FileUploadingPageState extends State<FileUploadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Uploading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  PlatformFile file = result.files.first;

                  // Check if we are on the web and adjust accordingly
                  if (!kIsWeb) {
                    String? filePath = file.path;
                    if (filePath != null) {
                      await uploadFile(file);
                      // Proceed with your file upload logic
                      // Handle the case where the file path is null
                      print("File path is null.");
                    }
                  } else {
                    // For web, you can still proceed with the upload using bytes
                    await uploadFile(file);
                    print("Uploaded file on web.");
                  }
                } else {
                  // User canceled the picker
                  print("User canceled the file picker.");
                }
              },
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
