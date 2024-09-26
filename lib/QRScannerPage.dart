import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // Points counter starts at 0
  int points = 0;
  var scannedQuestions = [];

  // Mapping QR code results to questions and correct answers
  final Map<String, Map<String, String>> questions = {
    "1": {"question": "What is the command to create a new Flutter project?", "answer": "flutter create"},
    "2": {"question": "Which keyword is used to declare a constant in Dart?", "answer": "const"},
    "3": {"question": "What is the main method of stateful widget lifecycle?", "answer": "initState"},
    "4": {"question": "Which method is used to listen for stream data in Dart?", "answer": "listen"},
    "5": {"question": "Which operator is used to call the superclass constructor in Dart?", "answer": "super"},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BYTECode QR Scanner'),  // Display the current points in the app bar
      ),
      body: Container(
        color: Colors.black,  // Set background color to black
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Image.asset(
              "images/bytecode.png",
              width: 120,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Add padding around QRView
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black, // Black background for QRView container
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Total Points: $points',  // Display the total points scored
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();  // Pause camera after scan
      if (result != null && questions.containsKey(result!.code)) {
        // Show alert with the question related to the QR result
        _showAlertWithInput(result!.code!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No question found for this QR code!')),
        );
        controller.resumeCamera(); // Resume camera if no valid question is found
      }
    });
  }

  // Function to show the alert dialog with the question based on scanned result
  Future<void> _showAlertWithInput(String code) async {

    if (scannedQuestions.contains(code)){
      TextEditingController answerController = TextEditingController();
      String question = questions[code]?["question"] ?? "No question available"; // Get question based on scanned code
      String correctAnswer = questions[code]?["answer"] ?? ""; // Get the correct answer
      // Show the alert dialog
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // Prevents closing the alert without interaction
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("QR Code already scanned. Can't scan a QR Twise"),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Try another QR')),
                  );
                  controller?.resumeCamera();
                },
              ),
            ],
          );
        },
      );
    } else {

      scannedQuestions.add(code);

      TextEditingController answerController = TextEditingController();
      String question = questions[code]?["question"] ?? "No question available"; // Get question based on scanned code
      String correctAnswer = questions[code]?["answer"] ?? ""; // Get the correct answer

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // Prevents closing the alert without interaction
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Question: $question'),
            content: TextField(
              controller: answerController,
              decoration: InputDecoration(hintText: 'Enter your answer'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Submit'),
                onPressed: () {
                  String enteredAnswer = answerController.text.trim();
                  if (enteredAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Correct answer!')),
                    );
                    setState(() {
                      points += 1;  // Increment points if the answer is correct
                    });
                    controller?.resumeCamera();  // Resume camera after correct answer
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Incorrect answer, try again!')),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}