import 'dart:async';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameService {
  WebSocketChannel? _channel;
  final StreamController<GameState> _stateController =
      StreamController<GameState>.broadcast();
  final _logger = Logger('GameService');

  Stream<GameState> get stateStream => _stateController.stream;

  void connect(String roomId, String playerId) {
    // Determine host - localhost for now, assume generic port 8080 if not specified
    // For Simulator/Emulator, localhost might need 10.0.2.2 or similar, but for MacOS desktop it's localhost.
    // Use LAN IP for network access
    // Replace 192.168.1.60 with your actual machine IP if it changes
    final uri = Uri.parse(
      'ws://192.168.1.60:8080/ws?roomId=$roomId&playerId=$playerId',
    );

    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen(
      (data) {
        try {
          final json = jsonDecode(data);
          if (json is Map<String, dynamic> && json.containsKey('id')) {
            final state = GameState.fromJson(json);
            _stateController.add(state);
          } else if (json.containsKey('error')) {
            // Handle error (maybe add to a separate error stream)
            _logger.warning("Server Error: ${json['error']}");
          }
        } catch (e) {
          _logger.warning("Error parsing state: $e");
        }
      },
      onError: (e) => _logger.severe("WS Error: $e"),
      onDone: () => _logger.info("WS Closed"),
    );
  }

  void send(ClientMessage message) {
    if (_channel != null) {
      _channel!.sink.add(message.toJson());
    }
  }

  void dispose() {
    _channel?.sink.close();
    _stateController.close();
  }
}
