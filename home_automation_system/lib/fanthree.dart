import 'package:flutter/material.dart';
import 'package:flutter_node_auth/services/ESP_services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Fanthree extends StatefulWidget {
  @override
  _FanthreeState createState() => _FanthreeState();
}

class _FanthreeState extends State<Fanthree> {
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
    setState(() {});
    if (speech.isListening) {
      setState(() {
        speech.stop();
      });

      return;
    }

    speech.listen(
      onResult: (result) {
        setState(() {
          transcription = result.recognizedWords.toLowerCase();

          if (transcription == 'turn off fan') {
            fanState = 0;
            isValid = true;
          } else if (transcription == 'turn on fan') {
            fanState = 1;
            isValid = true;
          } else {
            isValid = false;
          }
          if (isValid) handleSwitch();
        });
      },
    );
  }

  void handleSwitch() {
    ESPServices espServices = ESPServices();
    if (fanState == 1) {
      espServices.turnOnLed('fan3');
    } else {
      espServices.turnOffLed('fan3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('(Fan3)Speech to Text'),
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
                  value ? fanState = 1 : fanState = 0;
                  handleSwitch();
                  setState(() {});
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
