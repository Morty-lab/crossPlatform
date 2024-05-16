import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<void> uploadFile(PlatformFile file) async {
  String? _downloadURL;
  String? _filename; // Declare _filename here

  // Always read the file into a Uint8List
  Uint8List fileBytes = file.bytes!;

  // Assign the file name to _filename
  _filename = file.name; // Corrected line

  // Upload the Uint8List to Firebase Cloud Storage
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('uploads/${Uri.encodeComponent(_filename)}'); // Use _filename here
  UploadTask uploadTask = ref.putData(fileBytes);
  await uploadTask.whenComplete(() async {
    // Get the download URL after the upload is complete
    _downloadURL = await ref.getDownloadURL();
    // Store the filename and download URL in Firestore
    await FirebaseFirestore.instance.collection('uploads').add({
      'filename': _filename, // Now correctly using _filename
      'link': _downloadURL,
    });
    // Add a new document to the logs collection
    await FirebaseFirestore.instance.collection('logs').add({
      'logType': 'file_upload',
      'logTimeStamp': DateTime.now().toIso8601String(),
      'logInfo': _filename, // And here
    });
  });
}
