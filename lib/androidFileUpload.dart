import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

String? _downloadURL;

Future<void> uploadFile(PlatformFile file) async {
  Uint8List fileBytes = await File(file.path!).readAsBytes();

  // Upload the Uint8List to Firebase Cloud Storage
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('uploads/${Uri.encodeComponent(file.name)}');
  UploadTask uploadTask = ref.putData(fileBytes);
  await uploadTask.whenComplete(() async {
    // Get the download URL after the upload is complete
    _downloadURL = await ref.getDownloadURL();
    // Store the filename and download URL in Firestore
    await FirebaseFirestore.instance.collection('uploads').add({
      'filename': file.name,
      'link': _downloadURL,
    });
    // Add a new document to the logs collection
    await FirebaseFirestore.instance.collection('logs').add({
      'logType': 'files_upload',
      'logTimeStamp': DateTime.now().toIso8601String(),
      'logInfo': file.name,
    });
  });
}
