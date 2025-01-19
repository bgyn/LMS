import 'package:appwrite/appwrite.dart';
import 'package:lms/core/exceptions/exceptions.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:lms/injection_container.dart';
import 'package:uuid/uuid.dart';

class AppwriteAuthService {
  final Account _account = sl<Account>();

  Future<UserModel> isUserLoggedIn() async {
    try {
      final user = await _account.get();
      return UserModel.fromMap(user.toMap());
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        throw UnauthorizedException("User Not Logged In");
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      final user = await _account.get();
      return UserModel.fromMap(user.toMap());
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        throw Exception('Invalid email or password');
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> register(String email, String password, String name) async {
    Uuid uuid = const Uuid();
    try {
      await _account.create(
          userId: uuid.v4(), email: email, password: password, name: name);
      final user = await _account.get();
      return UserModel.fromMap(user.toMap());
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        throw Exception('User with this email already exist');
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
