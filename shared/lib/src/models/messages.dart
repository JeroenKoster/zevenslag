import 'package:dart_mappable/dart_mappable.dart';
import 'card.dart';

part 'messages.mapper.dart';

@MappableClass(discriminatorKey: 'type')
abstract class ClientMessage with ClientMessageMappable {
  const ClientMessage();
  static ClientMessage fromJson(Map<String, dynamic> json) =>
      ClientMessageMapper.fromMap(json);
}

@MappableClass(discriminatorValue: 'join')
class JoinMessage extends ClientMessage with JoinMessageMappable {
  final String roomId;
  final String playerName;
  const JoinMessage({required this.roomId, required this.playerName});
}

@MappableClass(discriminatorValue: 'start')
class StartMessage extends ClientMessage with StartMessageMappable {
  const StartMessage();
}

@MappableClass(discriminatorValue: 'bid')
class BidMessage extends ClientMessage with BidMessageMappable {
  final int amount;
  const BidMessage({required this.amount});
}

@MappableClass(discriminatorValue: 'play')
class PlayMessage extends ClientMessage with PlayMessageMappable {
  final PlayingCard card;
  const PlayMessage({required this.card});
}
