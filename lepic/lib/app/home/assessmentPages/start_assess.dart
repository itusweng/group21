import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/assessmentPages/record_audio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class StartAssessPage extends StatefulWidget {

  const StartAssessPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StartAssessPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _StartAssessPageState createState() =>
      _StartAssessPageState();
}

class _StartAssessPageState extends State<StartAssessPage> {
  String dropdownValue = 'Select Student';
  var _studentId ;
  var setDefaultMake = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Student',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          TextButton(
            onPressed: () => AudioPage.show(context, _studentId.toString()),
            child: Text('Start'),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],

      ),
      body: Column(
        children: [
          Text("Please Select a Student to Assess Reading Fluency",
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20.0,),),
          SizedBox(height: 8.0),
          Expanded(
            flex: 1,
            //child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .orderBy('studentId')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    _studentId = snapshot.data!.docs[0].get('studentId');
                    debugPrint('setDefault make: $_studentId');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: _studentId,
                    items: snapshot.data!.docs.map((value) {
                      return DropdownMenuItem(
                        value: value.get('studentId'),
                        child: Text('${value.get('studentId')}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('selected onchange: $value');
                      setState(
                            () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          _studentId = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                        },
                      );
                    },
                  );
                },
              ),
            //),
          ),

        ],
      ),
    );
  }
}