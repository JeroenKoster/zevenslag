// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'player.dart';

class PlayerMapper extends ClassMapperBase<Player> {
  PlayerMapper._();

  static PlayerMapper? _instance;
  static PlayerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayerMapper._());
      PlayingCardMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Player';

  static String _$id(Player v) => v.id;
  static const Field<Player, String> _f$id = Field('id', _$id);
  static String _$name(Player v) => v.name;
  static const Field<Player, String> _f$name = Field('name', _$name);
  static List<PlayingCard> _$hand(Player v) => v.hand;
  static const Field<Player, List<PlayingCard>> _f$hand = Field(
    'hand',
    _$hand,
    opt: true,
    def: const [],
  );
  static int? _$bid(Player v) => v.bid;
  static const Field<Player, int> _f$bid = Field('bid', _$bid, opt: true);
  static int _$tricksWon(Player v) => v.tricksWon;
  static const Field<Player, int> _f$tricksWon = Field(
    'tricksWon',
    _$tricksWon,
    opt: true,
    def: 0,
  );
  static int _$score(Player v) => v.score;
  static const Field<Player, int> _f$score = Field(
    'score',
    _$score,
    opt: true,
    def: 0,
  );
  static bool _$isReady(Player v) => v.isReady;
  static const Field<Player, bool> _f$isReady = Field(
    'isReady',
    _$isReady,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<Player> fields = const {
    #id: _f$id,
    #name: _f$name,
    #hand: _f$hand,
    #bid: _f$bid,
    #tricksWon: _f$tricksWon,
    #score: _f$score,
    #isReady: _f$isReady,
  };

  static Player _instantiate(DecodingData data) {
    return Player(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      hand: data.dec(_f$hand),
      bid: data.dec(_f$bid),
      tricksWon: data.dec(_f$tricksWon),
      score: data.dec(_f$score),
      isReady: data.dec(_f$isReady),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Player fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Player>(map);
  }

  static Player fromJson(String json) {
    return ensureInitialized().decodeJson<Player>(json);
  }
}

mixin PlayerMappable {
  String toJson() {
    return PlayerMapper.ensureInitialized().encodeJson<Player>(this as Player);
  }

  Map<String, dynamic> toMap() {
    return PlayerMapper.ensureInitialized().encodeMap<Player>(this as Player);
  }

  PlayerCopyWith<Player, Player, Player> get copyWith =>
      _PlayerCopyWithImpl<Player, Player>(this as Player, $identity, $identity);
  @override
  String toString() {
    return PlayerMapper.ensureInitialized().stringifyValue(this as Player);
  }

  @override
  bool operator ==(Object other) {
    return PlayerMapper.ensureInitialized().equalsValue(this as Player, other);
  }

  @override
  int get hashCode {
    return PlayerMapper.ensureInitialized().hashValue(this as Player);
  }
}

extension PlayerValueCopy<$R, $Out> on ObjectCopyWith<$R, Player, $Out> {
  PlayerCopyWith<$R, Player, $Out> get $asPlayer =>
      $base.as((v, t, t2) => _PlayerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlayerCopyWith<$R, $In extends Player, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get hand;
  $R call({
    String? id,
    String? name,
    List<PlayingCard>? hand,
    int? bid,
    int? tricksWon,
    int? score,
    bool? isReady,
  });
  PlayerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlayerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Player, $Out>
    implements PlayerCopyWith<$R, Player, $Out> {
  _PlayerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Player> $mapper = PlayerMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get hand => ListCopyWith(
    $value.hand,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(hand: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    List<PlayingCard>? hand,
    Object? bid = $none,
    int? tricksWon,
    int? score,
    bool? isReady,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (hand != null) #hand: hand,
      if (bid != $none) #bid: bid,
      if (tricksWon != null) #tricksWon: tricksWon,
      if (score != null) #score: score,
      if (isReady != null) #isReady: isReady,
    }),
  );
  @override
  Player $make(CopyWithData data) => Player(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    hand: data.get(#hand, or: $value.hand),
    bid: data.get(#bid, or: $value.bid),
    tricksWon: data.get(#tricksWon, or: $value.tricksWon),
    score: data.get(#score, or: $value.score),
    isReady: data.get(#isReady, or: $value.isReady),
  );

  @override
  PlayerCopyWith<$R2, Player, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlayerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

