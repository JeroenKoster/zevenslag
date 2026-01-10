import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:logging/logging.dart';
import 'package:server/game_manager.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  final logger = Logger('WebSocket');
  final handler = webSocketHandler((channel, protocol) {
    final query = context.request.uri.queryParameters;
    final roomId = query['roomId'] ?? 'default';
    final playerId =
        query['playerId'] ?? DateTime.now().millisecondsSinceEpoch.toString();

    final room = GameManager().getRoom(roomId);

    logger.info('Client connected: $playerId to $roomId');
    room.addClient(playerId, channel);

    channel.stream.listen(
      (message) {
        try {
          if (message is String) {
            final clientMsg = ClientMessageMapper.fromJson(message);
            room.handleMessage(playerId, clientMsg);
          }
        } catch (e) {
          logger.warning('Error handling message: $e');
        }
      },
      onDone: () {
        logger.info('Client disconnected: $playerId');
        room.removeClient(playerId);
      },
    );
  });

  return handler(context);
}
