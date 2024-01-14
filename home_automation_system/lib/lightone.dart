import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/services/ESP_services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Lightone extends StatefulWidget {
  @override
  _LightoneState createState() => _LightoneState();
}

class _LightoneState extends State<Lightone> {
  late stt.SpeechToText speech;
  String transcription = '';
  bool isValid = true;

  int state = 0;

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

          if (transcription == 'turn off light') {
            state = 0;
            isValid = true;
          } else if (transcription == 'turn on light') {
            state = 1;
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
    if (state == 1) {
      espServices.turnOnLed('led1');
    } else {
      espServices.turnOffLed('led1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('(Light1)Speech to Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                        "HERE YOU CAN TURN ON AND OFF YOUR DEVICE BY VOICE COMMANDS",
                        speed: Duration(milliseconds: 10)),
                  ],
                ),
              ),
              const Text(
                'Transcription:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(transcription,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(state.toString(), style: const TextStyle(fontSize: 20)),
              Switch(
                value: state == 1 ? true : false,
                onChanged: (value) {
                  value ? state = 1 : state = 0;

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
