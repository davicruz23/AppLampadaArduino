import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Controle de Lâmpada'),
        ),
        body: LampadaControle(),
      ),
    );
  }
}

class LampadaControle extends StatefulWidget {
  const LampadaControle({Key? key}) : super(key: key);

  @override
  _LampadaControleState createState() => _LampadaControleState();
}

class _LampadaControleState extends State<LampadaControle> {
  final String deviceName = "Nome_Do_Seu_Arduino";
  late BluetoothDevice device;
  late BluetoothCharacteristic characteristic;

  @override
  void initState() {
    super.initState();
    FlutterBlue.instance.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.name == deviceName) {
          setState(() {
            device = result.device;
          });
          _connectToDevice();
        }
      }
    });
    FlutterBlue.instance.startScan();
  }

  Future<void> _connectToDevice() async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((char) {
        if (char.uuid.toString() == "0000ffe1-0000-1000-8000-00805f9b34fb") {
          setState(() {
            characteristic = char;
          });
        }
      });
    });
  }

  void _sendCommand(String command) async {
    if (characteristic != null) {
      List<int> bytes = utf8.encode(command);
      await characteristic.write(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _sendCommand('1'); // Enviar comando para ligar
            },
            child: const Text('Ligar Lâmpada'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _sendCommand('0'); // Enviar comando para desligar
            },
            child: const Text('Desligar Lâmpada'),
          ),
        ],
      ),
    );
  }
}
