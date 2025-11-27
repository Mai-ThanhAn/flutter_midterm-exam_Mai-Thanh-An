import 'dart:async';
import 'dart:isolate';
import 'dart:math';

// --- MAIN ISOLATE ---
void main() async {
  print("--- MAIN: Starting console application ---");

  // 1. Create a ReceivePort for the Main isolate to receive messages
  final mainReceivePort = ReceivePort();

  // 2. Spawn a new worker Isolate, sending Main's SendPort so the Worker can communicate back
  await Isolate.spawn(workerIsolate, mainReceivePort.sendPort);

  // Variable to store the SendPort to communicate with the Worker (will be received from Worker)
  SendPort? workerSendPort;
  int totalSum = 0;

  // 3. Listen for messages from the Worker
  // mainReceivePort provides a Stream of incoming messages
  await for (var message in mainReceivePort) {
    
    // Case 1: Worker sends its SendPort to Main (Handshake)
    if (message is SendPort) {
      workerSendPort = message;
      print("--- MAIN: Connected to Worker. Starting to receive numbers... ---");
    } 
    
    // Case 2: Worker sends a random number
    else if (message is int) {
      totalSum += message;
      print("MAIN: Received $message -> Current total: $totalSum");

      // Check stopping condition
      if (totalSum > 100) {
        print("--- MAIN: Total > 100. Sending STOP command to Worker... ---");
        // Send STOP command back to Worker
        workerSendPort?.send("STOP");
        
        // Close the port and end Main (otherwise Main would hang)
        mainReceivePort.close(); 
        print("--- MAIN: Program finished ---");
        break; 
      }
    }
  }
}

// --- WORKER ISOLATE (runs in background) ---
void workerIsolate(SendPort mainSendPort) {
  // 1. Create a ReceivePort for the Worker to listen to messages from Main
  final workerReceivePort = ReceivePort();

  // 2. Send this port to Main so Main can communicate back (Handshake)
  mainSendPort.send(workerReceivePort.sendPort);

  // 3. Setup a Timer to send a random number every second
  final random = Random();
  Timer? timer;

  timer = Timer.periodic(Duration(seconds: 1), (t) {
    int randomNumber = random.nextInt(20) + 1; // Random number between 1 and 20
    print("WORKER: Sending number $randomNumber");
    mainSendPort.send(randomNumber);
  });

  // 4. Listen for commands from Main
  workerReceivePort.listen((message) {
    if (message == "STOP") {
      print("WORKER: Received STOP command. Exiting...");
      timer?.cancel(); // Cancel the timer
      workerReceivePort.close(); // Close the port
      Isolate.exit(); // Gracefully exit the Isolate
    }
  });
}