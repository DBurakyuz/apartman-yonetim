// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'due.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Due _$DueFromJson(Map<String, dynamic> json) {
  return _Due.fromJson(json);
}

/// @nodoc
mixin _$Due {
  String get id =>
      throw _privateConstructorUsedError; // Faturanın seri numarası (Firebase ID)
  String get residentId =>
      throw _privateConstructorUsedError; // Borçlu kişinin UID'si
  double get amount =>
      throw _privateConstructorUsedError; // Tutar (Kuruşlu olabilsin diye double kullanıyoruz)
  String get title =>
      throw _privateConstructorUsedError; // Hangi ay? (Örn: "Şubat 2024")
  bool get isPaid =>
      throw _privateConstructorUsedError; // Ödendi mi? (Evet: true, Hayır: false)
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Fatura kesim tarihi
  String get apartmentId => throw _privateConstructorUsedError;

  /// Serializes this Due to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Due
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DueCopyWith<Due> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DueCopyWith<$Res> {
  factory $DueCopyWith(Due value, $Res Function(Due) then) =
      _$DueCopyWithImpl<$Res, Due>;
  @useResult
  $Res call({
    String id,
    String residentId,
    double amount,
    String title,
    bool isPaid,
    DateTime createdAt,
    String apartmentId,
  });
}

/// @nodoc
class _$DueCopyWithImpl<$Res, $Val extends Due> implements $DueCopyWith<$Res> {
  _$DueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Due
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? residentId = null,
    Object? amount = null,
    Object? title = null,
    Object? isPaid = null,
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
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            isPaid: null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$DueImplCopyWith<$Res> implements $DueCopyWith<$Res> {
  factory _$$DueImplCopyWith(_$DueImpl value, $Res Function(_$DueImpl) then) =
      __$$DueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String residentId,
    double amount,
    String title,
    bool isPaid,
    DateTime createdAt,
    String apartmentId,
  });
}

/// @nodoc
class __$$DueImplCopyWithImpl<$Res> extends _$DueCopyWithImpl<$Res, _$DueImpl>
    implements _$$DueImplCopyWith<$Res> {
  __$$DueImplCopyWithImpl(_$DueImpl _value, $Res Function(_$DueImpl) _then)
    : super(_value, _then);

  /// Create a copy of Due
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? residentId = null,
    Object? amount = null,
    Object? title = null,
    Object? isPaid = null,
    Object? createdAt = null,
    Object? apartmentId = null,
  }) {
    return _then(
      _$DueImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        residentId: null == residentId
            ? _value.residentId
            : residentId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        isPaid: null == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$DueImpl implements _Due {
  const _$DueImpl({
    required this.id,
    required this.residentId,
    required this.amount,
    required this.title,
    required this.isPaid,
    required this.createdAt,
    required this.apartmentId,
  });

  factory _$DueImpl.fromJson(Map<String, dynamic> json) =>
      _$$DueImplFromJson(json);

  @override
  final String id;
  // Faturanın seri numarası (Firebase ID)
  @override
  final String residentId;
  // Borçlu kişinin UID'si
  @override
  final double amount;
  // Tutar (Kuruşlu olabilsin diye double kullanıyoruz)
  @override
  final String title;
  // Hangi ay? (Örn: "Şubat 2024")
  @override
  final bool isPaid;
  // Ödendi mi? (Evet: true, Hayır: false)
  @override
  final DateTime createdAt;
  // Fatura kesim tarihi
  @override
  final String apartmentId;

  @override
  String toString() {
    return 'Due(id: $id, residentId: $residentId, amount: $amount, title: $title, isPaid: $isPaid, createdAt: $createdAt, apartmentId: $apartmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.residentId, residentId) ||
                other.residentId == residentId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
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
    amount,
    title,
    isPaid,
    createdAt,
    apartmentId,
  );

  /// Create a copy of Due
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DueImplCopyWith<_$DueImpl> get copyWith =>
      __$$DueImplCopyWithImpl<_$DueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DueImplToJson(this);
  }
}

abstract class _Due implements Due {
  const factory _Due({
    required final String id,
    required final String residentId,
    required final double amount,
    required final String title,
    required final bool isPaid,
    required final DateTime createdAt,
    required final String apartmentId,
  }) = _$DueImpl;

  factory _Due.fromJson(Map<String, dynamic> json) = _$DueImpl.fromJson;

  @override
  String get id; // Faturanın seri numarası (Firebase ID)
  @override
  String get residentId; // Borçlu kişinin UID'si
  @override
  double get amount; // Tutar (Kuruşlu olabilsin diye double kullanıyoruz)
  @override
  String get title; // Hangi ay? (Örn: "Şubat 2024")
  @override
  bool get isPaid; // Ödendi mi? (Evet: true, Hayır: false)
  @override
  DateTime get createdAt; // Fatura kesim tarihi
  @override
  String get apartmentId;

  /// Create a copy of Due
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DueImplCopyWith<_$DueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
