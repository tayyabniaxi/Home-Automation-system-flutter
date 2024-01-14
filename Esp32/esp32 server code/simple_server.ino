//
// A simple server implementation showing how to:
//  * serve static messages
//  * read GET and POST parameters
//  * handle missing pages / 404s
//
#include <Wire.h>
#include <Arduino.h>
#ifdef ESP32
#include <WiFi.h>
#include <AsyncTCP.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <ESPAsyncTCP.h>
#endif
#include <ESPAsyncWebSrv.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#define DHT_TYPE DHT22    // Change this to DHT22 or DHT21 if you have a different sensor type

AsyncWebServer server(80);

const char* ssid = "esp";
const char* password = "123";
bool automateWaterPump = true;
const int led1Pin = 2;  // GPIO pin for LED 1
const int led2Pin = 4;  // GPIO pin for LED 2
const int led3Pin = 5;  // GPIO pin for LED 3
const int led4Pin = 18;  // GPIO pin for LED 4
const int led5Pin = 19;  // GPIO pin for LED 5
const int fan1Pin = 22;
const int fan2Pin = 23;
const int fan3Pin = 13;
const int WATER_SENSOR_PIN = 32;
const int MOTOR_PIN = 21;
const int DHT_PIN= 25 ;        // Pin for DHT sensor data
const int HEATER_PIN =27;      // GPIO pin for heater
const int AC_PIN= 14 ;


const char* PARAM_MESSAGE = "message";

void notFound(AsyncWebServerRequest *request) {
    request->send(404, "text/plain", "Not found");
}
DHT dht(DHT_PIN, DHT_TYPE);

void setup() {

    Serial.begin(115200);
    dht.begin();

    pinMode(led1Pin, OUTPUT);
    pinMode(led2Pin, OUTPUT);
    pinMode(led3Pin, OUTPUT);
    pinMode(led4Pin, OUTPUT);
    pinMode(led5Pin, OUTPUT);
    pinMode(fan1Pin, OUTPUT);
    pinMode(fan2Pin, OUTPUT);
    pinMode(fan3Pin, OUTPUT);

    pinMode(DHT_PIN, INPUT);

    pinMode(WATER_SENSOR_PIN, INPUT);
    pinMode(MOTOR_PIN, OUTPUT);
    pinMode(HEATER_PIN, OUTPUT);
    pinMode(AC_PIN, OUTPUT);
    digitalWrite(led1Pin,LOW);
    digitalWrite(led2Pin,LOW);
    digitalWrite(led3Pin,LOW);
    digitalWrite(led4Pin,LOW);
    digitalWrite(led5Pin,LOW);


    WiFi.mode(WIFI_STA);
    WiFi.begin("ta", "00000000");
    if (WiFi.waitForConnectResult() != WL_CONNECTED) {
        Serial.printf("WiFi Failed!\n");
        return;
    }

    Serial.print("IP Address: ");
    Serial.println(WiFi.localIP());

    server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
        request->send(200, "text/plain", "Welcome to Esp32 webserver");
    });

    // Send a GET request to <IP>/get?message=<message>
    server.on("/get", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led1Pin, HIGH);

        if (request->hasParam(PARAM_MESSAGE)) {
            message = request->getParam(PARAM_MESSAGE)->value();
        } else {
            message = "No message sent";
        }
        request->send(200, "text/plain", "Hello, GET: " + message);
    });

        // get Temperature level
    server.on("/temp", HTTP_GET, [] (AsyncWebServerRequest *request) {
        float temp = dht.readTemperature();
        // int waterLevel = analogRead(WATER_SENSOR_PIN);
        
        // Convert the float waterLevel to a string
        String responseMessage = "" + String(temp) ;

      
        request->send(200, "text/plain",responseMessage);
    });

    // // Send a POST request to <IP>/post with a form field message set to <message>
    // server.on("/post", HTTP_POST, [](AsyncWebServerRequest *request){
    //     String message;
    //     digitalWrite(led1Pin, LOW);

    //     if (request->hasParam(PARAM_MESSAGE, true)) {
    //         message = request->getParam(PARAM_MESSAGE, true)->value();
    //     } else {
    //         message = "No message sent";
    //     }
    //     request->send(200, "text/plain", "Hello, POST: " + message);
    // });

    //-----------------------------> Water Level
   server.on("/waterlevel", HTTP_GET, [](AsyncWebServerRequest *request){
    int waterLevel = analogRead(WATER_SENSOR_PIN);

    // Convert the integer waterLevel to a string
    String responseMessage = "Water Level: " + String(waterLevel);

    request->send(200, "text/plain", responseMessage);
  });




    //-----------------------------> LED1
    //TURN ON THE led1 LIGHT
    server.on("/on/led1", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led1Pin, HIGH);
        request->send(200, "text/plain", "request recieved");


    });
     //TURN OFF THE LED1 LIGHT
    server.on("/off/led1", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led1Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });

     //-----------------------------> LED2

    //TURN ON THE LED2 LIGHT
    server.on("/on/led2", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led2Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE LED2 LIGHT
    server.on("/off/led2", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led2Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });

     //-----------------------------> LED3

      //TURN ON THE LED3 LIGHT
    server.on("/on/led3", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led3Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE LED3 LIGHT
    server.on("/off/led3", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led3Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });


     //-----------------------------> LED4

      //TURN ON THE LED4 LIGHT
    server.on("/on/led4", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led4Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE LED4 LIGHT
    server.on("/off/led4", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led4Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });

    //-----------------------------> LED5

      //TURN ON THE LED5 LIGHT
    server.on("/on/led5", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led5Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE LED5 LIGHT
    server.on("/off/led5", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(led5Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });


        //-----------------------------> FAN 1

    //TURN ON THE FAN 1 
    server.on("/on/fan1", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan1Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE FAN 1 
    server.on("/off/fan1", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan1Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });


        //-----------------------------> FAN 2

    //TURN ON THE FAN 2 
    server.on("/on/fan2", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan1Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE FAN 2 
    server.on("/off/fan2", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan2Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });    

    //-----------------------------> FAN 3

    //TURN ON THE FAN 3 
    server.on("/on/fan3", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan3Pin, HIGH);
        request->send(200, "text/plain", "request recieved");

    });
     //TURN OFF THE FAN 3 
    server.on("/off/fan3", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(fan3Pin, LOW);
        request->send(200, "text/plain", "request recieved");
    });  



    //-----------------------------> MOTOR

    //TURN ON THE MOTOR
    server.on("/on/motor", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
         digitalWrite(MOTOR_PIN, HIGH);
         automateWaterPump = false;
         request->send(200, "text/plain", "request recieved");

    });  

     //TURN OFF THE MOTOR
    server.on("/off/motor", HTTP_GET, [] (AsyncWebServerRequest *request) {
        String message;
        digitalWrite(MOTOR_PIN, LOW);
        automateWaterPump = false;
        request->send(200, "text/plain", "request recieved");

    });          

    server.onNotFound(notFound);

    server.begin();
}

void loop() {
  
    //read water level
   int waterLevel = analogRead(WATER_SENSOR_PIN);
   // Read temperature from DHT sensor
  float temperature = dht.readTemperature();
   //determine the motor state based on water level
   if(waterLevel==0 && automateWaterPump){
    digitalWrite(MOTOR_PIN, HIGH);
   }
   else if (automateWaterPump){
        digitalWrite(MOTOR_PIN, LOW);
   }

    // Check if temperature is above the threshold (30 degrees Celsius)
  if (temperature < 30.0) {
    // Turn on the heater
    digitalWrite(HEATER_PIN, HIGH);
    // Turn off the air conditioner
    digitalWrite(AC_PIN, LOW);
  } else {
    // Turn off the heater
    digitalWrite(HEATER_PIN, LOW);
    // Turn on the air conditioner
    digitalWrite(AC_PIN, HIGH);
  }
  Serial.println("water level");

  Serial.println(waterLevel);

    Serial.println("Tempreture");

  Serial.println(temperature);
  delay(1000);
}