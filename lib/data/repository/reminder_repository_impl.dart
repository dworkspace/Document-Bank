import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/data/response/reminder_responses.dart';
import 'package:document_bank/domain/model/reminder.dart';

import '../../core/utils/exceptions.dart';
import '../../domain/repository/reminder_repository.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  ReminderRepositoryImpl(this._networkInfo, this._remoteSource);

  @override
  Future<Either<CustomFailure, String>> addReminder(
      SetReminderRequest reminderRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final String response =
            await _remoteSource.addReminder(reminderRequest);

        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, List<Reminder>>> getReminders() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<ReminderResponse> response =
            await _remoteSource.getReminders();

        return Right(List<Reminder>.from(response.map(
            (response) => Reminder.fromReminderRespnse(response))).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, String>> deleteReminder(int id) async {
    if (await _networkInfo.isConnected()) {
      try {
        final String response = await _remoteSource.deleteReminder(id);

        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
