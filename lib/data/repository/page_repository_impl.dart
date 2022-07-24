import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/response/page_responses.dart';
import 'package:document_bank/domain/model/page.dart';
import 'package:document_bank/domain/repository/page_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class PageRepositoryImpl extends PageRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  PageRepositoryImpl(this._networkInfo, this._remoteSource);

  @override
  Future<Either<CustomFailure, List<PageModel>>> getPages() async {
    if (await _networkInfo.isConnected()) {
      try {
        final List<PageResponse> response = await _remoteSource.getPages();
        final List<PageModel> folders =
            List<PageModel>.from(response.map((e) => PageModel.fromPageResponse(e)))
                .toList();
        return Right(folders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
