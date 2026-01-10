// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'card.dart';

class SuitMapper extends EnumMapper<Suit> {
  SuitMapper._();

  static SuitMapper? _instance;
  static SuitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SuitMapper._());
    }
    return _instance!;
  }

  static Suit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Suit decode(dynamic value) {
    switch (value) {
      case r'clubs':
        return Suit.clubs;
      case r'diamonds':
        return Suit.diamonds;
      case r'hearts':
        return Suit.hearts;
      case r'spades':
        return Suit.spades;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Suit self) {
    switch (self) {
      case Suit.clubs:
        return r'clubs';
      case Suit.diamonds:
        return r'diamonds';
      case Suit.hearts:
        return r'hearts';
      case Suit.spades:
        return r'spades';
    }
  }
}

extension SuitMapperExtension on Suit {
  String toValue() {
    SuitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Suit>(this) as String;
  }
}

class RankMapper extends EnumMapper<Rank> {
  RankMapper._();

  static RankMapper? _instance;
  static RankMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RankMapper._());
    }
    return _instance!;
  }

  static Rank fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Rank decode(dynamic value) {
    switch (value) {
      case r'two':
        return Rank.two;
      case r'three':
        return Rank.three;
      case r'four':
        return Rank.four;
      case r'five':
        return Rank.five;
      case r'six':
        return Rank.six;
      case r'seven':
        return Rank.seven;
      case r'eight':
        return Rank.eight;
      case r'nine':
        return Rank.nine;
      case r'ten':
        return Rank.ten;
      case r'jack':
        return Rank.jack;
      case r'queen':
        return Rank.queen;
      case r'king':
        return Rank.king;
      case r'ace':
        return Rank.ace;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Rank self) {
    switch (self) {
      case Rank.two:
        return r'two';
      case Rank.three:
        return r'three';
      case Rank.four:
        return r'four';
      case Rank.five:
        return r'five';
      case Rank.six:
        return r'six';
      case Rank.seven:
        return r'seven';
      case Rank.eight:
        return r'eight';
      case Rank.nine:
        return r'nine';
      case Rank.ten:
        return r'ten';
      case Rank.jack:
        return r'jack';
      case Rank.queen:
        return r'queen';
      case Rank.king:
        return r'king';
      case Rank.ace:
        return r'ace';
    }
  }
}

extension RankMapperExtension on Rank {
  String toValue() {
    RankMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Rank>(this) as String;
  }
}

class PlayingCardMapper extends ClassMapperBase<PlayingCard> {
  PlayingCardMapper._();

  static PlayingCardMapper? _instance;
  static PlayingCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayingCardMapper._());
      SuitMapper.ensureInitialized();
      RankMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlayingCard';

  static Suit _$suit(PlayingCard v) => v.suit;
  static const Field<PlayingCard, Suit> _f$suit = Field('suit', _$suit);
  static Rank _$rank(PlayingCard v) => v.rank;
  static const Field<PlayingCard, Rank> _f$rank = Field('rank', _$rank);

  @override
  final MappableFields<PlayingCard> fields = const {
    #suit: _f$suit,
    #rank: _f$rank,
  };

  static PlayingCard _instantiate(DecodingData data) {
    return PlayingCard(suit: data.dec(_f$suit), rank: data.dec(_f$rank));
  }

  @override
  final Function instantiate = _instantiate;

  static PlayingCard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayingCard>(map);
  }

  static PlayingCard fromJson(String json) {
    return ensureInitialized().decodeJson<PlayingCard>(json);
  }
}

mixin PlayingCardMappable {
  String toJson() {
    return PlayingCardMapper.ensureInitialized().encodeJson<PlayingCard>(
      this as PlayingCard,
    );
  }

  Map<String, dynamic> toMap() {
    return PlayingCardMapper.ensureInitialized().encodeMap<PlayingCard>(
      this as PlayingCard,
    );
  }

  PlayingCardCopyWith<PlayingCard, PlayingCard, PlayingCard> get copyWith =>
      _PlayingCardCopyWithImpl<PlayingCard, PlayingCard>(
        this as PlayingCard,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlayingCardMapper.ensureInitialized().stringifyValue(
      this as PlayingCard,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlayingCardMapper.ensureInitialized().equalsValue(
      this as PlayingCard,
      other,
    );
  }

  @override
  int get hashCode {
    return PlayingCardMapper.ensureInitialized().hashValue(this as PlayingCard);
  }
}

extension PlayingCardValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlayingCard, $Out> {
  PlayingCardCopyWith<$R, PlayingCard, $Out> get $asPlayingCard =>
      $base.as((v, t, t2) => _PlayingCardCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlayingCardCopyWith<$R, $In extends PlayingCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Suit? suit, Rank? rank});
  PlayingCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlayingCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlayingCard, $Out>
    implements PlayingCardCopyWith<$R, PlayingCard, $Out> {
  _PlayingCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlayingCard> $mapper =
      PlayingCardMapper.ensureInitialized();
  @override
  $R call({Suit? suit, Rank? rank}) => $apply(
    FieldCopyWithData({
      if (suit != null) #suit: suit,
      if (rank != null) #rank: rank,
    }),
  );
  @override
  PlayingCard $make(CopyWithData data) => PlayingCard(
    suit: data.get(#suit, or: $value.suit),
    rank: data.get(#rank, or: $value.rank),
  );

  @override
  PlayingCardCopyWith<$R2, PlayingCard, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlayingCardCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DeckMapper extends ClassMapperBase<Deck> {
  DeckMapper._();

  static DeckMapper? _instance;
  static DeckMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckMapper._());
      PlayingCardMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Deck';

  static List<PlayingCard> _$cards(Deck v) => v.cards;
  static const Field<Deck, List<PlayingCard>> _f$cards = Field(
    'cards',
    _$cards,
  );

  @override
  final MappableFields<Deck> fields = const {#cards: _f$cards};

  static Deck _instantiate(DecodingData data) {
    return Deck(cards: data.dec(_f$cards));
  }

  @override
  final Function instantiate = _instantiate;

  static Deck fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Deck>(map);
  }

  static Deck fromJson(String json) {
    return ensureInitialized().decodeJson<Deck>(json);
  }
}

mixin DeckMappable {
  String toJson() {
    return DeckMapper.ensureInitialized().encodeJson<Deck>(this as Deck);
  }

  Map<String, dynamic> toMap() {
    return DeckMapper.ensureInitialized().encodeMap<Deck>(this as Deck);
  }

  DeckCopyWith<Deck, Deck, Deck> get copyWith =>
      _DeckCopyWithImpl<Deck, Deck>(this as Deck, $identity, $identity);
  @override
  String toString() {
    return DeckMapper.ensureInitialized().stringifyValue(this as Deck);
  }

  @override
  bool operator ==(Object other) {
    return DeckMapper.ensureInitialized().equalsValue(this as Deck, other);
  }

  @override
  int get hashCode {
    return DeckMapper.ensureInitialized().hashValue(this as Deck);
  }
}

extension DeckValueCopy<$R, $Out> on ObjectCopyWith<$R, Deck, $Out> {
  DeckCopyWith<$R, Deck, $Out> get $asDeck =>
      $base.as((v, t, t2) => _DeckCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DeckCopyWith<$R, $In extends Deck, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get cards;
  $R call({List<PlayingCard>? cards});
  DeckCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DeckCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Deck, $Out>
    implements DeckCopyWith<$R, Deck, $Out> {
  _DeckCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Deck> $mapper = DeckMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PlayingCard,
    PlayingCardCopyWith<$R, PlayingCard, PlayingCard>
  >
  get cards => ListCopyWith(
    $value.cards,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(cards: v),
  );
  @override
  $R call({List<PlayingCard>? cards}) =>
      $apply(FieldCopyWithData({if (cards != null) #cards: cards}));
  @override
  Deck $make(CopyWithData data) =>
      Deck(cards: data.get(#cards, or: $value.cards));

  @override
  DeckCopyWith<$R2, Deck, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DeckCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

