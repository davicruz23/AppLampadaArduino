import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 236, 178, 6),
          title: Text('Controle de LED'),
        ),
        backgroundColor: const Color.fromARGB(
            255, 236, 178, 6), // Defina a cor de fundo para amarelo claro
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Enviar solicitação HTTP para ligar o LED
                  http.get(Uri.parse('http://192.168.244.142/ligar'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 151, 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.all(
                      20.0), // Adicione espaço interno para garantir a borda arredondada
                  minimumSize: Size(100, 100), // Ajuste conforme necessário
                ),
                child: const Text('LIGAR'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Enviar solicitação HTTP para desligar o LED
                  http.get(Uri.parse('http://192.168.244.142/desligar'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 234, 23, 23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.all(
                      20.0), // Adicione espaço interno para garantir a borda arredondada
                  minimumSize: Size(100, 100), // Ajuste conforme necessário
                ),
                child: const Text('DESLIGAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
