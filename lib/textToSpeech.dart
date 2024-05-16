import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    try {
      _isInitialized = await _speechToText.initialize();
      setState(() {});
    } catch (e) {
      print('Failed to initialize SpeechToText: $e');
      // Optionally, set _isInitialized to false or handle the failure differently
    }
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    if (_isInitialized) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    } else {
      // Handle the case where initialization failed or is still ongoing
      print('Initialization not yet complete');
    }
  }

  /// Manually stop the active speech recognition session
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      FirebaseFirestore.instance.collection('logs').add({
        'logType': 'Text to Speech',
        'logTimeStamp': DateTime.now().toIso8601String(),
        'logInfo': _lastWords,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _speechToText.isListening
                      ? '$_lastWords'
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
