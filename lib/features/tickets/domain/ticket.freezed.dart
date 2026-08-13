// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  String get id =>
      throw _privateConstructorUsedError; // Her talebin Firebase'deki benzersiz kimlik numarası
  String get residentId =>
      throw _privateConstructorUsedError; // Talebi açan kişinin UID'si
  String get authorName =>
      throw _privateConstructorUsedError; // Talebi açan kişinin adı (Ekranda göstermek için)
  String get title =>
      throw _privateConstructorUsedError; // Şikayet/Talep başlığı (Örn: Asansör Bozuk)
  String get description =>
      throw _privateConstructorUsedError; // Detaylı açıklama
  TicketStatus get status =>
      throw _privateConstructorUsedError; // Durumu (Bekliyor, Çözüldü, Reddedildi)
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Açılma tarihi ve saati
  String get apartmentId => throw _privateConstructorUsedError;

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call({
    String id,
    String residentId,
    String authorName,
    String title,
    String description,
    TicketStatus status,
    DateTime createdAt,
    String apartmentId,
  });
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? residentId = null,
    Object? authorName = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? apartmentId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            residentId: null == residentId
                ? _value.residentId
                : residentId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TicketStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            apartmentId: null == apartmentId
                ? _value.apartmentId
                : apartmentId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketImplCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$TicketImplCopyWith(
    _$TicketImpl value,
    $Res Function(_$TicketImpl) then,
  ) = __$$TicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String residentId,
    String authorName,
    String title,
    String description,
    TicketStatus status,
    DateTime createdAt,
    String apartmentId,
  });
}

/// @nodoc
class __$$TicketImplCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$TicketImpl>
    implements _$$TicketImplCopyWith<$Res> {
  __$$TicketImplCopyWithImpl(
    _$TicketImpl _value,
    $Res Function(_$TicketImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? residentId = null,
    Object? authorName = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? apartmentId = null,
  }) {
    return _then(
      _$TicketImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        residentId: null == residentId
            ? _value.residentId
            : residentId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TicketStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        apartmentId: null == apartmentId
            ? _value.apartmentId
            : apartmentId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketImpl implements _Ticket {
  const _$TicketImpl({
    required this.id,
    required this.residentId,
    required this.authorName,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.apartmentId,
  });

  factory _$TicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketImplFromJson(json);

  @override
  final String id;
  // Her talebin Firebase'deki benzersiz kimlik numarası
  @override
  final String residentId;
  // Talebi açan kişinin UID'si
  @override
  final String authorName;
  // Talebi açan kişinin adı (Ekranda göstermek için)
  @override
  final String title;
  // Şikayet/Talep başlığı (Örn: Asansör Bozuk)
  @override
  final String description;
  // Detaylı açıklama
  @override
  final TicketStatus status;
  // Durumu (Bekliyor, Çözüldü, Reddedildi)
  @override
  final DateTime createdAt;
  // Açılma tarihi ve saati
  @override
  final String apartmentId;

  @override
  String toString() {
    return 'Ticket(id: $id, residentId: $residentId, authorName: $authorName, title: $title, description: $description, status: $status, createdAt: $createdAt, apartmentId: $apartmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.residentId, residentId) ||
                other.residentId == residentId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.apartmentId, apartmentId) ||
                other.apartmentId == apartmentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    residentId,
    authorName,
    title,
    description,
    status,
    createdAt,
    apartmentId,
  );

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      __$$TicketImplCopyWithImpl<_$TicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketImplToJson(this);
  }
}

abstract class _Ticket implements Ticket {
  const factory _Ticket({
    required final String id,
    required final String residentId,
    required final String authorName,
    required final String title,
    required final String description,
    required final TicketStatus status,
    required final DateTime createdAt,
    required final String apartmentId,
  }) = _$TicketImpl;

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$TicketImpl.fromJson;

  @override
  String get id; // Her talebin Firebase'deki benzersiz kimlik numarası
  @override
  String get residentId; // Talebi açan kişinin UID'si
  @override
  String get authorName; // Talebi açan kişinin adı (Ekranda göstermek için)
  @override
  String get title; // Şikayet/Talep başlığı (Örn: Asansör Bozuk)
  @override
  String get description; // Detaylı açıklama
  @override
  TicketStatus get status; // Durumu (Bekliyor, Çözüldü, Reddedildi)
  @override
  DateTime get createdAt; // Açılma tarihi ve saati
  @override
  String get apartmentId;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
