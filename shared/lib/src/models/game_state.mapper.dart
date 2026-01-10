// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game_state.dart';

class GamePhaseMapper extends EnumMapper<GamePhase> {
  GamePhaseMapper._();

  static GamePhaseMapper? _instance;
  static GamePhaseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GamePhaseMapper._());
    }
    return _instance!;
  }

  static GamePhase fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  GamePhase decode(dynamic value) {
    switch (value) {
      case r'waiting':
        return GamePhase.waiting;
      case r'bidding':
        return GamePhase.bidding;
      case r'playing':
        return GamePhase.playing;
      case r'roundEnd':
        return GamePhase.roundEnd;
      case r'gameEnd':
        return GamePhase.gameEnd;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(GamePhase self) {
    switch (self) {
      case GamePhase.waiting:
        return r'waiting';
      case GamePhase.bidding:
        return r'bidding';
      case GamePhase.playing:
        return r'playing';
      case GamePhase.roundEnd:
        return r'roundEnd';
      case GamePhase.gameEnd:
        return r'gameEnd';
    }
  }
}

extension GamePhaseMapperExtension on GamePhase {
  String toValue() {
    GamePhaseMapper.ensureInitialized();
    return MapperContainer.globals.toValue<GamePhase>(this) as String;
  }
}

class TrickMapper extends ClassMapperBase<Trick> {
  TrickMapper._();

  static TrickMapper? _instance;
  static TrickMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TrickMapper._());
      PlayingCardMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Trick';

  static PlayingCard _$leadCard(Trick v) => v.leadCard;
  static const Field<Trick, PlayingCard> _f$leadCard = Field(
    'leadCard',
    _$leadCard,
  );
  static Map<String, PlayingCard> _$cardsPlayed(Trick v) => v.cardsPlayed;
  static const Field<Trick, Map<String, PlayingCard>> _f$cardsPlayed = Field(
    'cardsPlayed',
    _$cardsPlayed,
  );
  static String _$leadPlayerId(Trick v) => v.leadPlayerId;
  static const Field<Trick, String> _f$leadPlayerId = Field(
    'leadPlayerId',
    _$leadPlayerId,
  );

  @override
  final MappableFields<Trick> fields = const {
    #leadCard: _f$leadCard,
    #cardsPlayed: _f$cardsPlayed,
    #leadPlayerId: _f$leadPlayerId,
  };

  static Trick _instantiate(DecodingData data) {
    return Trick(
      leadCard: data.dec(_f$leadCard),
      cardsPlayed: data.dec(_f$cardsPlayed),
      leadPlayerId: data.dec(_f$leadPlayerId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Trick fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Trick>(map);
  }

  static Trick fromJson(String json) {
    return ensureInitialized().decodeJson<Trick>(json);
  }
}

mixin TrickMappable {
  String toJson() {
    return TrickMapper.ensureInitialized().encodeJson<Trick>(this as Trick);
  }

  Map<String, dynamic> toMap() {
    return TrickMapper.ensureInitialized().encodeMap<Trick>(this as Trick);
  }

  TrickCopyWith<Trick, Trick, Trick> get copyWith =>
      _TrickCopyWithImpl<Trick, Trick>(this as Trick, $identity, $identity);
  @override
  String toString() {
    return TrickMapper.ensureInitialized().stringifyValue(this as Trick);
  }

  @override
  bool operator ==(Object other) {
    return TrickMapper.ensureInitialized().equalsValue(this as Trick, other);
  }

  @override
  int get hashCode {
    return TrickMapper.ensureInitialized().hashValue(this as Trick);
  }
}

extension TrickValueCopy<$R, $Out> on ObjectCopyWith<$R, Trick, $Out> {
  TrickCopyWith<$R, Trick, $Out> get $asTrick =>
      $base.as((v, t, t2) => _TrickCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TrickCopyWith<$R, $In extends Trick, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard> get leadCard;
  MapCopyWith<
    $R,
    String,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get cardsPlayed;
  $R call({
    PlayingCard? leadCard,
    Map<String, PlayingCard>? cardsPlayed,
    String? leadPlayerId,
  });
  TrickCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TrickCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Trick, $Out>
    implements TrickCopyWith<$R, Trick, $Out> {
  _TrickCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Trick> $mapper = TrickMapper.ensureInitialized();
  @override
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard> get leadCard =>
      $value.leadCard.copyWith.$chain((v) => call(leadCard: v));
  @override
  MapCopyWith<
    $R,
    String,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get cardsPlayed => MapCopyWith(
    $value.cardsPlayed,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(cardsPlayed: v),
  );
  @override
  $R call({
    PlayingCard? leadCard,
    Map<String, PlayingCard>? cardsPlayed,
    String? leadPlayerId,
  }) => $apply(
    FieldCopyWithData({
      if (leadCard != null) #leadCard: leadCard,
      if (cardsPlayed != null) #cardsPlayed: cardsPlayed,
      if (leadPlayerId != null) #leadPlayerId: leadPlayerId,
    }),
  );
  @override
  Trick $make(CopyWithData data) => Trick(
    leadCard: data.get(#leadCard, or: $value.leadCard),
    cardsPlayed: data.get(#cardsPlayed, or: $value.cardsPlayed),
    leadPlayerId: data.get(#leadPlayerId, or: $value.leadPlayerId),
  );

  @override
  TrickCopyWith<$R2, Trick, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TrickCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GameStateMapper extends ClassMapperBase<GameState> {
  GameStateMapper._();

  static GameStateMapper? _instance;
  static GameStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameStateMapper._());
      PlayerMapper.ensureInitialized();
      GamePhaseMapper.ensureInitialized();
      PlayingCardMapper.ensureInitialized();
      TrickMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameState';

  static String _$id(GameState v) => v.id;
  static const Field<GameState, String> _f$id = Field('id', _$id);
  static List<Player> _$players(GameState v) => v.players;
  static const Field<GameState, List<Player>> _f$players = Field(
    'players',
    _$players,
    opt: true,
    def: const [],
  );
  static GamePhase _$phase(GameState v) => v.phase;
  static const Field<GameState, GamePhase> _f$phase = Field(
    'phase',
    _$phase,
    opt: true,
    def: GamePhase.waiting,
  );
  static int _$roundNumber(GameState v) => v.roundNumber;
  static const Field<GameState, int> _f$roundNumber = Field(
    'roundNumber',
    _$roundNumber,
    opt: true,
    def: 1,
  );
  static int _$cardsInRound(GameState v) => v.cardsInRound;
  static const Field<GameState, int> _f$cardsInRound = Field(
    'cardsInRound',
    _$cardsInRound,
    opt: true,
    def: 1,
  );
  static PlayingCard? _$trumpCard(GameState v) => v.trumpCard;
  static const Field<GameState, PlayingCard> _f$trumpCard = Field(
    'trumpCard',
    _$trumpCard,
    opt: true,
  );
  static Trick? _$currentTrick(GameState v) => v.currentTrick;
  static const Field<GameState, Trick> _f$currentTrick = Field(
    'currentTrick',
    _$currentTrick,
    opt: true,
  );
  static int _$currentPlayerIndex(GameState v) => v.currentPlayerIndex;
  static const Field<GameState, int> _f$currentPlayerIndex = Field(
    'currentPlayerIndex',
    _$currentPlayerIndex,
    opt: true,
    def: 0,
  );
  static int _$dealerIndex(GameState v) => v.dealerIndex;
  static const Field<GameState, int> _f$dealerIndex = Field(
    'dealerIndex',
    _$dealerIndex,
    opt: true,
    def: 0,
  );
  static String? _$winnerId(GameState v) => v.winnerId;
  static const Field<GameState, String> _f$winnerId = Field(
    'winnerId',
    _$winnerId,
    opt: true,
  );

  @override
  final MappableFields<GameState> fields = const {
    #id: _f$id,
    #players: _f$players,
    #phase: _f$phase,
    #roundNumber: _f$roundNumber,
    #cardsInRound: _f$cardsInRound,
    #trumpCard: _f$trumpCard,
    #currentTrick: _f$currentTrick,
    #currentPlayerIndex: _f$currentPlayerIndex,
    #dealerIndex: _f$dealerIndex,
    #winnerId: _f$winnerId,
  };

  static GameState _instantiate(DecodingData data) {
    return GameState(
      id: data.dec(_f$id),
      players: data.dec(_f$players),
      phase: data.dec(_f$phase),
      roundNumber: data.dec(_f$roundNumber),
      cardsInRound: data.dec(_f$cardsInRound),
      trumpCard: data.dec(_f$trumpCard),
      currentTrick: data.dec(_f$currentTrick),
      currentPlayerIndex: data.dec(_f$currentPlayerIndex),
      dealerIndex: data.dec(_f$dealerIndex),
      winnerId: data.dec(_f$winnerId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameState>(map);
  }

  static GameState fromJson(String json) {
    return ensureInitialized().decodeJson<GameState>(json);
  }
}

mixin GameStateMappable {
  String toJson() {
    return GameStateMapper.ensureInitialized().encodeJson<GameState>(
      this as GameState,
    );
  }

  Map<String, dynamic> toMap() {
    return GameStateMapper.ensureInitialized().encodeMap<GameState>(
      this as GameState,
    );
  }

  GameStateCopyWith<GameState, GameState, GameState> get copyWith =>
      _GameStateCopyWithImpl<GameState, GameState>(
        this as GameState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameStateMapper.ensureInitialized().stringifyValue(
      this as GameState,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameStateMapper.ensureInitialized().equalsValue(
      this as GameState,
      other,
    );
  }

  @override
  int get hashCode {
    return GameStateMapper.ensureInitialized().hashValue(this as GameState);
  }
}

extension GameStateValueCopy<$R, $Out> on ObjectCopyWith<$R, GameState, $Out> {
  GameStateCopyWith<$R, GameState, $Out> get $asGameState =>
      $base.as((v, t, t2) => _GameStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameStateCopyWith<$R, $In extends GameState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Player, PlayerCopyWith<$R, Player, Player>> get players;
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard>? get trumpCard;
  TrickCopyWith<$R, Trick, Trick>? get currentTrick;
  $R call({
    String? id,
    List<Player>? players,
    GamePhase? phase,
    int? roundNumber,
    int? cardsInRound,
    PlayingCard? trumpCard,
    Trick? currentTrick,
    int? currentPlayerIndex,
    int? dealerIndex,
    String? winnerId,
  });
  GameStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameState, $Out>
    implements GameStateCopyWith<$R, GameState, $Out> {
  _GameStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameState> $mapper =
      GameStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Player, PlayerCopyWith<$R, Player, Player>> get players =>
      ListCopyWith(
        $value.players,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(players: v),
      );
  @override
  PlayingCardCopyWith<$R, PlayingCard, PlayingCard>? get trumpCard =>
      $value.trumpCard?.copyWith.$chain((v) => call(trumpCard: v));
  @override
  TrickCopyWith<$R, Trick, Trick>? get currentTrick =>
      $value.currentTrick?.copyWith.$chain((v) => call(currentTrick: v));
  @override
  $R call({
    String? id,
    List<Player>? players,
    GamePhase? phase,
    int? roundNumber,
    int? cardsInRound,
    Object? trumpCard = $none,
    Object? currentTrick = $none,
    int? currentPlayerIndex,
    int? dealerIndex,
    Object? winnerId = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (players != null) #players: players,
      if (phase != null) #phase: phase,
      if (roundNumber != null) #roundNumber: roundNumber,
      if (cardsInRound != null) #cardsInRound: cardsInRound,
      if (trumpCard != $none) #trumpCard: trumpCard,
      if (currentTrick != $none) #currentTrick: currentTrick,
      if (currentPlayerIndex != null) #currentPlayerIndex: currentPlayerIndex,
      if (dealerIndex != null) #dealerIndex: dealerIndex,
      if (winnerId != $none) #winnerId: winnerId,
    }),
  );
  @override
  GameState $make(CopyWithData data) => GameState(
    id: data.get(#id, or: $value.id),
    players: data.get(#players, or: $value.players),
    phase: data.get(#phase, or: $value.phase),
    roundNumber: data.get(#roundNumber, or: $value.roundNumber),
    cardsInRound: data.get(#cardsInRound, or: $value.cardsInRound),
    trumpCard: data.get(#trumpCard, or: $value.trumpCard),
    currentTrick: data.get(#currentTrick, or: $value.currentTrick),
    currentPlayerIndex: data.get(
      #currentPlayerIndex,
      or: $value.currentPlayerIndex,
    ),
    dealerIndex: data.get(#dealerIndex, or: $value.dealerIndex),
    winnerId: data.get(#winnerId, or: $value.winnerId),
  );

  @override
  GameStateCopyWith<$R2, GameState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

