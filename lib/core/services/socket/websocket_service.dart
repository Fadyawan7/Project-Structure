import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static const String _baseUrl = 'wss://your-websocket-url.com/ws';

  WebSocketChannel? _channel;
  Timer? _pingTimer;

  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get messagesStream => _messageController.stream;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnected) return;

    _channel = WebSocketChannel.connect(Uri.parse(_baseUrl));

    _channel!.stream.listen(
      _handleMessage,
      onError: _handleError,
      onDone: _handleDisconnection,
    );

    _isConnected = true;
    _startPingTimer();
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(jsonEncode(message));
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final Map<String, dynamic> data = jsonDecode(message);

      if (data.containsKey('ping')) {
        _channel?.sink.add(jsonEncode({"pong": data['ping']}));
        return;
      }

      // 🔥 Send data to UI
      _messageController.add(data);

    } catch (_) {}
  }

  void _sendPing() {
    _channel?.sink.add(jsonEncode({"method": "PING"}));
  }

  void _startPingTimer() {
    _pingTimer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => _sendPing(),
    );
  }

  void _handleError(error) {
    _isConnected = false;
    Future.delayed(const Duration(seconds: 5), reconnect);
  }

  void _handleDisconnection() {
    _isConnected = false;
    Future.delayed(const Duration(seconds: 5), reconnect);
  }

  Future<void> reconnect() async {
    await disconnect();
    await connect();
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
  }

  void dispose() {
    _messageController.close();
    disconnect();
  }
}