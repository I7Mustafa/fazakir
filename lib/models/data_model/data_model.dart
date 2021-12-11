import 'package:fazakir/models/date_model/date_model.dart';
import 'package:fazakir/models/timings_model/timings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel {
  factory DataModel({
    required Timings timings,
    required DateModel date,
    required Set meta,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
}
