#include <BluetoothSerial.h>

BluetoothSerial SerialBT;

void setup() {
  Serial.begin(115200);
  SerialBT.begin("ESP32Bluetooth"); // Nome do dispositivo Bluetooth
}

void loop() {
  if (SerialBT.available()) {
    char command = SerialBT.read();

    if (command == '1') {
      digitalWrite(LED_BUILTIN, HIGH); // Ligar a lâmpada
    } else if (command == '0') {
      digitalWrite(LED_BUILTIN, LOW); // Desligar a lâmpada
    }
  }
}
