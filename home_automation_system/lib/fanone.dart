import 'package:flutter/material.dart';
import 'package:flutter_node_auth/services/ESP_services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Fanone extends StatefulWidget {
  @override
  _FanoneState createState() => _FanoneState();
}

class _FanoneState extends State<Fanone> {
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
  void startListening() async {
    
    if (speech.isListening) {
      await speech.cancel().then((value){
         setState(() {
        
      });
      });
      return;
    }

    await speech.listen(
      
      onResult: (result) {
        setState(() {
          transcription = result.recognizedWords.toLowerCase();
          print(transcription);

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
    ).then((value){
      setState(() {
        
      });
    });
  }

  void handleSwitch() {
    ESPServices espServices = ESPServices();
    if (fanState == 1) {
      espServices.turnOnLed('fan1');
    } else {
      espServices.turnOffLed('fan1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('(Fan1)Speech to Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                'Transcription: ',
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
