import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/scheduler/data/models/schedule_monthly_data_model.dart';

class ScheduleMonthlyResponseModel {
  final bool success;

  final String message;

  final int status;

  final ScheduleMonthlyDataModel data;

  const ScheduleMonthlyResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ScheduleMonthlyResponseModel.fromMap(Map<String, dynamic> map) {
    return ScheduleMonthlyResponseModel(
      success: ParserUtils.readBool(map['success']),

      message: ParserUtils.readString(map['message']),

      status: ParserUtils.readInt(map['status']),

      data: ScheduleMonthlyDataModel.fromMap(ParserUtils.readMap(map['data'])),
    );
  }
}
