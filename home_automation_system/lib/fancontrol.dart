import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



class SpeechToTextApp extends StatefulWidget {
  @override
  _SpeechToTextAppState createState() => _SpeechToTextAppState();
}

class _SpeechToTextAppState extends State<SpeechToTextApp> {
  late stt.SpeechToText speech;
  String transcription = '';
  bool isValid = true;

  int fanState = 0;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() {});
    }
  }

//this function calls when press on mic icon
  void startListening() {
    if (speech.isListening) {
      setState(() {
        speech.stop();
      });

      return;
    }

    speech.listen(
      onResult: (result) {
        setState(() {
          transcription = result.recognizedWords;

          if (transcription == 'turn off') {
            fanState = 0;
            isValid = true;
          } else if (transcription == 'turn on') {
            fanState = 1;
            isValid = true;
          } else {
            isValid = false;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech to Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Transcription:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(transcription, style: const TextStyle(fontSize: 20)),
              Text(fanState.toString(), style: const TextStyle(fontSize: 20)),
              Switch(
                value: fanState == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    value ? fanState = 1 : fanState = 0;
                  });
                },
              ),
              isValid ? const SizedBox.shrink() : const Text("Invalid command"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {startListening(), setState(() {})},
          child: speech.isListening
              ? const Icon(Icons.stop)
              : const Icon(Icons.mic),
        ),
      ),
    );
  }
}