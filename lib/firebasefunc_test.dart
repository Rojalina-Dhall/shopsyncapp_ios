import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FireBaseFuncPage extends StatefulWidget {
  const FireBaseFuncPage({super.key});

  @override
  State<FireBaseFuncPage> createState() => _FireBaseFuncPageState();
}

class _FireBaseFuncPageState extends State<FireBaseFuncPage> {
  String _output = "Press the button to call function";

  Future<void> callHelloWorld() async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('helloWorld');
      final result = await callable({'name': 'Rojalina'});

      setState(() {
        _output = result.data.toString();
      });
    } catch (e) {
      setState(() {
        _output = "Error calling function: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Functions Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _output,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: callHelloWorld,
              child: const Text('Call helloWorld Function'),
            ),
          ],
        ),
      ),
    );
  }
}
