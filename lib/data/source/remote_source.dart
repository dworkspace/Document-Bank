import 'package:dio/dio.dart';
import 'package:document_bank/core/utils/exceptions.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/request/document_requests.dart';
import 'package:document_bank/data/request/memo_requests.dart';
import 'package:document_bank/data/request/note_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/data/response/document_responses.dart';
import 'package:document_bank/data/response/memo_responses.dart';
import 'package:document_bank/data/response/note_responses.dart';

import '../response/goal_responses.dart';

abstract class RemoteSource {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<String> register(RegisterRequest registerRequest);

  Future<OtpVerifyResponse> verifyOtp(OtpVerifyRequest otpVerifyRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<ForgotPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);

  Future<List<TodoGoalResponse>> createTodoGoal(String title);

  Future<List<TodoGoalResponse>> getTodoGoals();

  Future<List<MemoResponse>> getImportantMemos();

  Future<List<MemoResponse>> createMemo(CreateMemoRequest memoRequest);

  Future<List<FolderResponse>> getAllFolders();

  Future<List<DocumentResponse>> addDocuments(
      AddDocumentsRequest addDocumentsRequest);

  Future<List<NoteResponse>> getAllNotes();

  Future<List<NoteResponse>> saveNote(AddNoteRequest addNoteRequest);
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
  Future<ForgotPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      final loginResponse = await dio.post(
        "/reset-password",
        data: resetPasswordRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return ForgotPasswordResponse.fromMap(mapBody);
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
  Future<List<DocumentResponse>> addDocuments(
      AddDocumentsRequest addDocumentsRequest) async {
    try {
      List<MultipartFile> files = [];

      Map<String, dynamic> mapData = {};

      for (var path in addDocumentsRequest.paths) {
        files.add(await MultipartFile.fromFile(path));
      }

      for (var element in files) {
        mapData["document[]"] = element;
      }

      mapData['folder'] = addDocumentsRequest.folderName;
      var formData = FormData.fromMap(mapData);

      final storeDocumentsResponse =
          await dio.post("/store-document", data: formData);
      final mapBody = storeDocumentsResponse.data;
      final List<Map<String, dynamic>> _list =
          List<Map<String, dynamic>>.from(mapBody['data']);
      return List<DocumentResponse>.from(
          _list.map((e) => DocumentResponse.fromMap(e))).toList();
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<NoteResponse>> getAllNotes() async {
    try {
      final notesResponse = await dio.get("/note");
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
}
