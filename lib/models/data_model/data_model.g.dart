// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataModel _$$_DataModelFromJson(Map<String, dynamic> json) => _$_DataModel(
      timings: Timings.fromJson(json['timings'] as Map<String, dynamic>),
      date: DateModel.fromJson(json['date'] as Map<String, dynamic>),
      meta: (json['meta'] as List<dynamic>).toSet(),
    );

Map<String, dynamic> _$$_DataModelToJson(_$_DataModel instance) =>
    <String, dynamic>{
      'timings': instance.timings,
      'date': instance.date,
      'meta': instance.meta.toList(),
    };
