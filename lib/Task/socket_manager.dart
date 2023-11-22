import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class SocketScreen extends StatefulWidget {
  @override
  State<SocketScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SocketScreen> {
  final TextEditingController _controller = TextEditingController();
  late final WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    // Replace 'wss://echo.websocket.events' with your WebSocket server URL
    _channel = IOWebSocketChannel.connect('wss://echo.websocket.events');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text('WebSocket closed');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      _controller.clear(); // Clear the input field after sending the message
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
