// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketImpl _$$TicketImplFromJson(Map<String, dynamic> json) => _$TicketImpl(
  id: json['id'] as String,
  residentId: json['residentId'] as String,
  authorName: json['authorName'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  status: $enumDecode(_$TicketStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  apartmentId: json['apartmentId'] as String,
);

Map<String, dynamic> _$$TicketImplToJson(_$TicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'residentId': instance.residentId,
      'authorName': instance.authorName,
      'title': instance.title,
      'description': instance.description,
      'status': _$TicketStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'apartmentId': instance.apartmentId,
    };

const _$TicketStatusEnumMap = {
  TicketStatus.pending: 'pending',
  TicketStatus.resolved: 'resolved',
  TicketStatus.rejected: 'rejected',
};
