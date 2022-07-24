import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/domain/model/document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit(this._dio) : super(DownloadState());

  void downloadImage(Document document) async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    if (await _requestPermission(Permission.storage)) {
      try {
        var directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/Download";
        directory = Directory(newPath);

        if (!await directory.exists()) {
          directory.create();
        }
        final docName = DateTime.now().millisecondsSinceEpoch.toString();
        final response = await _dio.download(
            document.photo, '${directory.path}/$docName.jpg');

        if (response.statusCode == 200) {
          emit(state.copyWith(status: StateStatusEnum.success));
        } else {
          emit(state.copyWith(status: StateStatusEnum.failure));
        }
      } catch (e) {
        emit(state.copyWith(status: StateStatusEnum.failure));
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  final Dio _dio;
}
