import 'package:bytecode/QRScannerPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Sets the background color of the screen to black
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height, // Set container height to screen height
            alignment: Alignment.center, // Center the container content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Image.asset(
                    "images/depLogos.png",
                    // width: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Image.asset(
                    "images/bytecode.png",
                    // width: 120,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'in collaboration with',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 10),
                  child: Image.asset(
                    "images/dects.png",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.white, // Sets the text color to white
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your Team Name',
                      hintStyle: const TextStyle(
                        color: Colors.white70, // Sets the hint text color to a slightly lighter white
                      ),
                      filled: true, // Fills the background color
                      fillColor: Colors.grey[850], // Dark grey background to contrast with black
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.grey, // Border color when not focused
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Button wrapped in a Container for consistent width
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0), // Add padding for consistent width
                  child: Container(
                    width: double.infinity, // Makes the button take the full width of the container
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerPage()))
                      },
                      child: const Text(
                        'START',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
