import 'package:logging/logging.dart';
import 'package:server/game_room.dart';

/// Manages the creation and retrieval of [GameRoom] instances.
class GameManager {
  /// Factory constructor to return the singleton instance.
  factory GameManager() => _instance;
  GameManager._internal();

  static final GameManager _instance = GameManager._internal();
  final _logger = Logger('GameManager');

  final Map<String, GameRoom> _rooms = {};

  /// Retrieves or creates a [GameRoom] with the given [id].
  GameRoom getRoom(String id) {
    if (!_rooms.containsKey(id)) {
      _rooms[id] = GameRoom(id);
      _logger.info('Created room $id');
    }
    return _rooms[id]!;
  }

  // Optional clean up empty rooms logic
}
