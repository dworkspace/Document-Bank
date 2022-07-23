import 'package:dio/dio.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/core/utils/exceptions.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/data/request/memo_requests.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/data/response/document_responses.dart';
import 'package:document_bank/data/response/memo_responses.dart';
import 'package:document_bank/data/response/note_responses.dart';
import 'package:document_bank/data/response/profile_responses.dart';
import 'package:document_bank/data/response/reminder_responses.dart';
import 'package:document_bank/domain/model/note_folder.dart';

import '../response/goal_responses.dart';

abstract class RemoteSource {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<String> register(RegisterRequest registerRequest);

  Future<AccountSetupResponse> accountSetup(
      AccountSetupRequest accountSetupRequest);

  Future<OtpVerifyResponse> verifyOtp(OtpVerifyRequest otpVerifyRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<String> resetPassword(ResetPasswordRequest resetPasswordRequest);

  Future<List<TodoGoalResponse>> createTodoGoal(String title);

  Future<List<TodoGoalResponse>> getTodoGoals();

  Future<List<TodoGoalResponse>> completeGoal(int goalId);

  Future<String> deleteAllGoals();

  Future<List<MemoResponse>> getImportantMemos();

  Future<List<MemoResponse>> createMemo(CreateMemoRequest memoRequest);

  Future<List<FolderResponse>> getAllFolders();

  Future<List<NoteFolderResponse>> getNoteFolders();

  Future<List<AddDocumentResponse>> addDocuments(
      AddDocumentsRequest addDocumentsRequest);

  Future<List<DocumentResponse>> getAllDocuments();

  Future<List<DocumentResponse>> deleteDocuments(String ids);

  Future<List<DocumentResponse>> getDocumentsOfFolder(int folderId);

  Future<List<NoteResponse>> getAllNotesOfFolder(NoteFolder noteFolder);

  Future<List<NoteResponse>> saveNote(AddNoteRequest addNoteRequest);

  Future<List<NoteResponse>> updateNote(AddNoteRequest addNoteRequest);

  Future<String> addReminder(SetReminderRequest reminderRequest);

  Future<List<ReminderResponse>> getReminders();

  Future<String> deleteReminder(int id);

  Future<ProfileResponse> getProfile();

  Future<ProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest);
}

class RemoteSourceImpl implements RemoteSource {
  final Dio dio;

  RemoteSourceImpl(this.dio);

  /*
   * USER LOGIN
   */
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final loginResponse = await dio.post(
        "/login",
        data: loginRequest.toMap(),
      );
      final mapBody = loginResponse.data['data'];
      return LoginResponse.fromLoginResponse(mapBody);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /*
   * USER REGISTER
   */
  @override
  Future<String> register(RegisterRequest registerRequest) async {
    try {
      final loginResponse = await dio.post(
        "/register-user",
        data: registerRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AccountSetupResponse> accountSetup(
      AccountSetupRequest accountSetupRequest) async {
    try {
      var formData = FormData.fromMap(accountSetupRequest.toJson());

      final fileMultipart =
          await MultipartFile.fromFile(accountSetupRequest.photoPath);
      formData.files.add(MapEntry("photo", fileMultipart));

      final response = await dio.post("/account-setup", data: formData);
      final mapBody = response.data;
      final AccountSetupResponse accountSetupResponse =
          AccountSetupResponse.fromJson(mapBody);
      return accountSetupResponse;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
 * ACTIVATE ACCOUNT
 */
  @override
  Future<OtpVerifyResponse> verifyOtp(OtpVerifyRequest otpVerifyRequest) async {
    try {
      final loginResponse = await dio.post(
        otpVerifyRequest.endURL,
        data: otpVerifyRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return OtpVerifyResponse.fromMap(mapBody);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
 * FORGOT PASSWORD
 */
  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      final loginResponse = await dio.post(
        "/forget-password",
        data: {"email": email},
      );
      final mapBody = loginResponse.data;
      return ForgotPasswordResponse.fromMap(mapBody);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
   *  RESET PASSWORD (FORGOT PASSWORD)
   */
  @override
  Future<String> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      final loginResponse = await dio.post(
        "/reset-password",
        data: resetPasswordRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return mapBody["message"];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
   * CREATE GOAL
   */
  @override
  Future<List<TodoGoalResponse>> createTodoGoal(String title) async {
    try {
      final loginResponse = await dio.post(
        "/goal",
        data: {"title": title},
      );
      final mapBody = loginResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<TodoGoalResponse>.from(
          _list.map((e) => TodoGoalResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
   * GET ALL  GOALS
   */
  @override
  Future<List<TodoGoalResponse>> getTodoGoals() async {
    try {
      final loginResponse = await dio.get(
        "/goal",
      );
      final mapBody = loginResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<TodoGoalResponse>.from(
          _list.map((e) => TodoGoalResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
 * Get Important Memos
 */
  @override
  Future<List<MemoResponse>> getImportantMemos() async {
    try {
      final memosResponse = await dio.get(
        "/important-memo",
      );
      final mapBody = memosResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<MemoResponse>.from(_list.map((e) => MemoResponse.fromMap(e)))
          .toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
   * CREATE MEMO
   */
  @override
  Future<List<MemoResponse>> createMemo(CreateMemoRequest memoRequest) async {
    try {
      final memosResponse =
          await dio.post("/important-memo", data: memoRequest.toMap());
      final mapBody = memosResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<MemoResponse>.from(_list.map((e) => MemoResponse.fromMap(e)))
          .toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<FolderResponse>> getAllFolders() async {
    try {
      final memosResponse = await dio.get("/folder");
      final mapBody = memosResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<FolderResponse>.from(
          _list.map((e) => FolderResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<NoteFolderResponse>> getNoteFolders() async {
    try {
      final noteFolderResponse = await dio.get("/note-folder");
      final mapBody = noteFolderResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<NoteFolderResponse>.from(
          _list.map((e) => NoteFolderResponse.fromJson(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AddDocumentResponse>> addDocuments(
      AddDocumentsRequest addDocumentsRequest) async {
    try {
      List<MultipartFile> files = [];

      Map<String, dynamic> mapData = {
        "folder": addDocumentsRequest.folderName,
      };

      var formData = FormData.fromMap(mapData);

      for (var path in addDocumentsRequest.paths) {
        formData.files.addAll(
            [MapEntry("document[]", await MultipartFile.fromFile(path))]);
      }

      final storeDocumentsResponse =
          await dio.post("/store-document", data: formData);
      final mapBody = storeDocumentsResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<AddDocumentResponse>.from(
          _list.map((e) => AddDocumentResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<NoteResponse>> getAllNotesOfFolder(NoteFolder noteFolder) async {
    try {
      final notesResponse = await dio.get("/note?folder=${noteFolder.id}");
      final mapBody = notesResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<NoteResponse>.from(_list.map((e) => NoteResponse.fromMap(e)))
          .toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<NoteResponse>> saveNote(AddNoteRequest addNoteRequest) async {
    try {
      final notesResponse =
          await dio.post("/note", data: addNoteRequest.toMap());
      final mapBody = notesResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<NoteResponse>.from(_list.map((e) => NoteResponse.fromMap(e)))
          .toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<NoteResponse>> updateNote(AddNoteRequest addNoteRequest) async {
    try {
      final notesResponse = await dio.put("/note/${addNoteRequest.id}",
          data: addNoteRequest.toMap());
      final mapBody = notesResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<NoteResponse>.from(_list.map((e) => NoteResponse.fromMap(e)))
          .toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<DocumentResponse>> getAllDocuments() async {
    try {
      final response = await dio.get("/all-documents");
      final mapBody = response.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<DocumentResponse>.from(
          _list.map((e) => DocumentResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<DocumentResponse>> getDocumentsOfFolder(int folderId) async {
    try {
      final response = await dio.get("/all-documents/$folderId");
      final mapBody = response.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<DocumentResponse>.from(
          _list.map((e) => DocumentResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> addReminder(SetReminderRequest reminderRequest) async {
    try {
      final url = reminderRequest.reminderOn == ReminderOnEnum.note
          ? "/remainder-memo"
          : "/remainder-photo";
      final response = await dio.post(url, data: reminderRequest.toMap());
      final mapBody = response.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ReminderResponse>> getReminders() async {
    try {
      final response = await dio.get("/remainder-memo");
      final mapBody = response.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<ReminderResponse>.from(
          _list.map((e) => ReminderResponse.fromJson(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> deleteReminder(int id) async {
    try {
      final response = await dio.delete("/remainder-memo/$id");
      final mapBody = response.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> deleteAllGoals() async {
    try {
      final response = await dio.post("/goal-delete");
      final mapBody = response.data;
      return mapBody['message'][0];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<TodoGoalResponse>> completeGoal(int goalId) async {
    try {
      final loginResponse =
          await dio.post("/goal-complete", data: {"id": goalId});
      final mapBody = loginResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<TodoGoalResponse>.from(
          _list.map((e) => TodoGoalResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<DocumentResponse>> deleteDocuments(String ids) async {
    try {
      final response =
          await dio.post("/delete-multiple-document", data: {"ids": ids});
      final mapBody = response.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<DocumentResponse>.from(
          _list.map((e) => DocumentResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final response = await dio.get("/show-profile");
      final mapBody = response.data;
      final ProfileResponse profileResponse =
          ProfileResponse.fromJson(mapBody['data']);
      return profileResponse;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    try {
      var formData = FormData.fromMap(updateProfileRequest.toJson());

      if (updateProfileRequest.imagePath != null) {
        final fileMultipart =
            await MultipartFile.fromFile(updateProfileRequest.imagePath!);
        formData.files.add(MapEntry("photo", fileMultipart));
      }

      final response = await dio.post("/update-profile", data: formData);
      final mapBody = response.data;
      final ProfileResponse profileResponse =
          ProfileResponse.fromJson(mapBody['data']);
      return profileResponse;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
