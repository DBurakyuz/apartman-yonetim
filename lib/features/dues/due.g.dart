// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DueImpl _$$DueImplFromJson(Map<String, dynamic> json) => _$DueImpl(
  id: json['id'] as String,
  residentId: json['residentId'] as String,
  amount: (json['amount'] as num).toDouble(),
  title: json['title'] as String,
  isPaid: json['isPaid'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  apartmentId: json['apartmentId'] as String,
);

Map<String, dynamic> _$$DueImplToJson(_$DueImpl instance) => <String, dynamic>{
  'id': instance.id,
  'residentId': instance.residentId,
  'amount': instance.amount,
  'title': instance.title,
  'isPaid': instance.isPaid,
  'createdAt': instance.createdAt.toIso8601String(),
  'apartmentId': instance.apartmentId,
};
