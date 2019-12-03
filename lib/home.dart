import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  String _username = "";
  String _password = "";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry Page"),
      ),
      body: Column(children: <Widget>[
        Text('Books'),
        Expanded(
          child: StreamBuilder(
            stream: Firestore.instance.collection('books').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Center(child: new CircularProgressIndicator());
              }
              return ListView.separated(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _listItem(context, snapshot.data.documents[index]),
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Container(width: 50, child: Image.network(document['image'])),
      title: Text(document['title']),
      subtitle: Text(document['author']),
      trailing: Text(document['price'].toString()),
    );
  }
}
