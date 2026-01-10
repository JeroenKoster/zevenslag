// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'messages.dart';

class ClientMessageMapper extends ClassMapperBase<ClientMessage> {
  ClientMessageMapper._();

  static ClientMessageMapper? _instance;
  static ClientMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMessageMapper._());
      JoinMessageMapper.ensureInitialized();
      StartMessageMapper.ensureInitialized();
      BidMessageMapper.ensureInitialized();
      PlayMessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClientMessage';

  @override
  final MappableFields<ClientMessage> fields = const {};

  static ClientMessage _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'ClientMessage',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClientMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientMessage>(map);
  }

  static ClientMessage fromJson(String json) {
    return ensureInitialized().decodeJson<ClientMessage>(json);
  }
}

mixin ClientMessageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ClientMessageCopyWith<ClientMessage, ClientMessage, ClientMessage>
  get copyWith;
}

abstract class ClientMessageCopyWith<$R, $In extends ClientMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ClientMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class JoinMessageMapper extends SubClassMapperBase<JoinMessage> {
  JoinMessageMapper._();

  static JoinMessageMapper? _instance;
  static JoinMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JoinMessageMapper._());
      ClientMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'JoinMessage';

  static String _$roomId(JoinMessage v) => v.roomId;
  static const Field<JoinMessage, String> _f$roomId = Field('roomId', _$roomId);
  static String _$playerName(JoinMessage v) => v.playerName;
  static const Field<JoinMessage, String> _f$playerName = Field(
    'playerName',
    _$playerName,
  );

  @override
  final MappableFields<JoinMessage> fields = const {
    #roomId: _f$roomId,
    #playerName: _f$playerName,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'join';
  @override
  late final ClassMapperBase superMapper =
      ClientMessageMapper.ensureInitialized();

  static JoinMessage _instantiate(DecodingData data) {
    return JoinMessage(
      roomId: data.dec(_f$roomId),
      playerName: data.dec(_f$playerName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static JoinMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<JoinMessage>(map);
  }

  static JoinMessage fromJson(String json) {
    return ensureInitialized().decodeJson<JoinMessage>(json);
  }
}

mixin JoinMessageMappable {
  String toJson() {
    return JoinMessageMapper.ensureInitialized().encodeJson<JoinMessage>(
      this as JoinMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return JoinMessageMapper.ensureInitialized().encodeMap<JoinMessage>(
      this as JoinMessage,
    );
  }

  JoinMessageCopyWith<JoinMessage, JoinMessage, JoinMessage> get copyWith =>
      _JoinMessageCopyWithImpl<JoinMessage, JoinMessage>(
        this as JoinMessage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return JoinMessageMapper.ensureInitialized().stringifyValue(
      this as JoinMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return JoinMessageMapper.ensureInitialized().equalsValue(
      this as JoinMessage,
      other,
    );
  }

  @override
  int get hashCode {
    return JoinMessageMapper.ensureInitialized().hashValue(this as JoinMessage);
  }
}

extension JoinMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, JoinMessage, $Out> {
  JoinMessageCopyWith<$R, JoinMessage, $Out> get $asJoinMessage =>
      $base.as((v, t, t2) => _JoinMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class JoinMessageCopyWith<$R, $In extends JoinMessage, $Out>
    implements ClientMessageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? roomId, String? playerName});
  JoinMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JoinMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, JoinMessage, $Out>
    implements JoinMessageCopyWith<$R, JoinMessage, $Out> {
  _JoinMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JoinMessage> $mapper =
      JoinMessageMapper.ensureInitialized();
  @override
  $R call({String? roomId, String? playerName}) => $apply(
    FieldCopyWithData({
      if (roomId != null) #roomId: roomId,
      if (playerName != null) #playerName: playerName,
    }),
  );
  @override
  JoinMessage $make(CopyWithData data) => JoinMessage(
    roomId: data.get(#roomId, or: $value.roomId),
    playerName: data.get(#playerName, or: $value.playerName),
  );

  @override
  JoinMessageCopyWith<$R2, JoinMessage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _JoinMessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StartMessageMapper extends SubClassMapperBase<StartMessage> {
  StartMessageMapper._();

  static StartMessageMapper? _instance;
  static StartMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StartMessageMapper._());
      ClientMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'StartMessage';

  @override
  final MappableFields<StartMessage> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'start';
  @override
  late final ClassMapperBase superMapper =
      ClientMessageMapper.ensureInitialized();

  static StartMessage _instantiate(DecodingData data) {
    return StartMessage();
  }

  @override
  final Function instantiate = _instantiate;

  static StartMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StartMessage>(map);
  }

  static StartMessage fromJson(String json) {
    return ensureInitialized().decodeJson<StartMessage>(json);
  }
}

mixin StartMessageMappable {
  String toJson() {
    return StartMessageMapper.ensureInitialized().encodeJson<StartMessage>(
      this as StartMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return StartMessageMapper.ensureInitialized().encodeMap<StartMessage>(
      this as StartMessage,
    );
  }

  StartMessageCopyWith<StartMessage, StartMessage, StartMessage> get copyWith =>
      _StartMessageCopyWithImpl<StartMessage, StartMessage>(
        this as StartMessage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StartMessageMapper.ensureInitialized().stringifyValue(
      this as StartMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return StartMessageMapper.ensureInitialized().equalsValue(
      this as StartMessage,
      other,
    );
  }

  @override
  int get hashCode {
    return StartMessageMapper.ensureInitialized().hashValue(
      this as StartMessage,
    );
  }
}

extension StartMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StartMessage, $Out> {
  StartMessageCopyWith<$R, StartMessage, $Out> get $asStartMessage =>
      $base.as((v, t, t2) => _StartMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StartMessageCopyWith<$R, $In extends StartMessage, $Out>
    implements ClientMessageCopyWith<$R, $In, $Out> {
  @override
  $R call();
  StartMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StartMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StartMessage, $Out>
    implements StartMessageCopyWith<$R, StartMessage, $Out> {
  _StartMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StartMessage> $mapper =
      StartMessageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  StartMessage $make(CopyWithData data) => StartMessage();

  @override
  StartMessageCopyWith<$R2, StartMessage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StartMessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BidMessageMapper extends SubClassMapperBase<BidMessage> {
  BidMessageMapper._();

  static BidMessageMapper? _instance;
  static BidMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BidMessageMapper._());
      ClientMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'BidMessage';

  static int _$amount(BidMessage v) => v.amount;
  static const Field<BidMessage, int> _f$amount = Field('amount', _$amount);

  @override
  final MappableFields<BidMessage> fields = const {#amount: _f$amount};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'bid';
  @override
  late final ClassMapperBase superMapper =
      ClientMessageMapper.ensureInitialized();

  static BidMessage _instantiate(DecodingData data) {
    return BidMessage(amount: data.dec(_f$amount));
  }

  @override
  final Function instantiate = _instantiate;

  static BidMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BidMessage>(map);
  }

  static BidMessage fromJson(String json) {
    return ensureInitialized().decodeJson<BidMessage>(json);
  }
}

mixin BidMessageMappable {
  String toJson() {
    return BidMessageMapper.ensureInitialized().encodeJson<BidMessage>(
      this as BidMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return BidMessageMapper.ensureInitialized().encodeMap<BidMessage>(
      this as BidMessage,
    );
  }

  BidMessageCopyWith<BidMessage, BidMessage, BidMessage> get copyWith =>
      _BidMessageCopyWithImpl<BidMessage, BidMessage>(
        this as BidMessage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BidMessageMapper.ensureInitialized().stringifyValue(
      this as BidMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return BidMessageMapper.ensureInitialized().equalsValue(
      this as BidMessage,
      other,
    );
  }

  @override
  int get hashCode {
    return BidMessageMapper.ensureInitialized().hashValue(this as BidMessage);
  }
}

extension BidMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BidMessage, $Out> {
  BidMessageCopyWith<$R, BidMessage, $Out> get $asBidMessage =>
      $base.as((v, t, t2) => _BidMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BidMessageCopyWith<$R, $In extends BidMessage, $Out>
    implements ClientMessageCopyWith<$R, $In, $Out> {
  @override
  $R call({int? amount});
  BidMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BidMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BidMessage, $Out>
    implements BidMessageCopyWith<$R, BidMessage, $Out> {
  _BidMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BidMessage> $mapper =
      BidMessageMapper.ensureInitialized();
  @override
  $R call({int? amount}) =>
      $apply(FieldCopyWithData({if (amount != null) #amount: amount}));
  @override
  BidMessage $make(CopyWithData data) =>
      BidMessage(amount: data.get(#amount, or: $value.amount));

  @override
  BidMessageCopyWith<$R2, BidMessage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BidMessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PlayMessageMapper extends SubClassMapperBase<PlayMessage> {
  PlayMessageMapper._();

  static PlayMessageMapper? _instance;
  static PlayMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayMessageMapper._());
      ClientMessageMapper.ensureInitialized().addSubMapper(_instance!);
      PlayingCardMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlayMessage';

  static PlayingCard _$card(PlayMessage v) => v.card;
  static const Field<PlayMessage, PlayingCard> _f$card = Field('card', _$card);

  @override
  final MappableFields<PlayMessage> fields = const {#card: _f$card};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'play';
  @override
  late final ClassMapperBase superMapper =
      ClientMessageMapper.ensureInitialized();

  static PlayMessage _instantiate(DecodingData data) {
    return PlayMessage(card: data.dec(_f$card));
  }

  @override
  final Function instantiate = _instantiate;

  static PlayMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayMessage>(map);
  }

  static PlayMessage fromJson(String json) {
    return ensureInitialized().decodeJson<PlayMessage>(json);
  }
}

mixin PlayMessageMappable {
  String toJson() {
    return PlayMessageMapper.ensureInitialized().encodeJson<PlayMessage>(
      this as PlayMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return PlayMessageMapper.ensureInitialized().encodeMap<PlayMessage>(
      this as PlayMessage,
    );
  }

  PlayMessageCopyWith<PlayMessage, PlayMessage, PlayMessage> get copyWith =>
      _PlayMessageCopyWithImpl<PlayMessage, PlayMessage>(
        this as PlayMessage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlayMessageMapper.ensureInitialized().stringifyValue(
      this as PlayMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlayMessageMapper.ensureInitialized().equalsValue(
      this as PlayMessage,
      other,
    );
  }

  @override
  int get hashCode {
    return PlayMessageMapper.ensureInitialized().hashValue(this as PlayMessage);
  }
}

extension PlayMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlayMessage, $Out> {
  PlayMessageCopyWith<$R, PlayMessage, $Out> get $asPlayMessage =>
      $base.as((v, t, t2) => _PlayMessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlayMessageCopyWith<$R, $In extends PlayMessage, $Out>
    implements ClientMessageCopyWith<$R, $In, $Out> {
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard> get card;
  @override
  $R call({PlayingCard? card});
  PlayMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlayMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlayMessage, $Out>
    implements PlayMessageCopyWith<$R, PlayMessage, $Out> {
  _PlayMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlayMessage> $mapper =
      PlayMessageMapper.ensureInitialized();
  @override
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard> get card =>
      $value.card.copyWith.$chain((v) => call(card: v));
  @override
  $R call({PlayingCard? card}) =>
      $apply(FieldCopyWithData({if (card != null) #card: card}));
  @override
  PlayMessage $make(CopyWithData data) =>
      PlayMessage(card: data.get(#card, or: $value.card));

  @override
  PlayMessageCopyWith<$R2, PlayMessage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlayMessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

