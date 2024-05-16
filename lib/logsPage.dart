import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('logs')
          .orderBy('logTimeStamp', descending: true)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(20.0),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return Column(
              children: [
                SizedBox(height: 10.0), // Adjust the height as needed
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  title: Text(document['logInfo']),
                  subtitle: Text(document['logTimeStamp']),
                  trailing: Text(document['logType']),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
