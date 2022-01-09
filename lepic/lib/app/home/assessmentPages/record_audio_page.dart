import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exp/app/home/assessmentPages/create_assessment_page.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:exp/app/home/statistics/statistics.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class AudioPage extends StatefulWidget {

  const AudioPage({ Key? key, this.studentId, this.assessId }) : super(key: key);
  final String? studentId;
  final String? assessId;

  static Future<void> show(BuildContext context, String studentId, String assessId) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AudioPage(studentId: studentId,assessId: assessId,),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  var text = "Taste is how food feels in your mouth. Basically, it is whether it is good food or not. For example, I think McDonald’s tastes good, but some people think it tastes bad. I think dark chocolate tastes better than milk chocolate, but you might think the opposite. If something tastes of nothing, then it does not have a strong taste.";

  var setDefaultMake = true;
  Duration duration = Duration();
  Timer? timer;

  void addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }


  @override
  Widget build(BuildContext context) {
    String twoDigites(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigites(duration.inMinutes.remainder(60));
    final seconds = twoDigites(duration.inSeconds.remainder(60));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recording',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme
              .of(context)
              .primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Statistics'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChartPage())
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('assessments')
                          .where('assessId', isEqualTo: widget.assessId)
                          .get()
                          .asStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (setDefaultMake) {
                          text = snapshot.data!.docs[0].get('text');
                        }
                        return Container(
                          child:
                          Text(
                              text,
                              style: TextStyle(fontSize: 25)
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      Text(
                          'Reading Time: $minutes:$seconds',
                          style: TextStyle(fontSize: 15, color: Colors.white)
                      ),
                      color: Colors.blue[600],
                    ),
                    SizedBox(height: 20,),
                    Text(
                      _text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue[300],
                      ),
                    ),
                    

                  ])
          ),
        )

    );
  }

  void _listen() async {
    if (!_isListening) {
      startTimer();
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>
              setState(() {
                _text = val.recognizedWords;
                if (val.hasConfidenceRating && val.confidence > 0) {
                  _confidence = val.confidence;
                }
              }),
        );
      }
    } else {
      stopTimer();
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
