import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? exportedImage;

  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.red,
    exportBackgroundColor: Colors.yellow,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text("Signature Pad"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Signature(
              controller: controller,
              height: 250,
              width: MediaQuery.of(context).size.width / 1.05,
              backgroundColor: Colors.lightBlue[100]!,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        exportedImage = await controller.toPngBytes();

                        setState(() {});
                      },
                      child: const Text(
                        "Save Signature",
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.clear();
                      },
                      child: const Text(
                        "Clear Signature",
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (exportedImage != null)
              Image.memory(
                exportedImage!,
                width: 300,
                height: 250,
              ),
            if (exportedImage != null)
              ElevatedButton(
                onPressed: () {
                  exportedImage = null;
                  setState(() {});
                },
                child: const Text("Clear Export"),
              ),
          ],
        ),
      ),
    );
  }
}
