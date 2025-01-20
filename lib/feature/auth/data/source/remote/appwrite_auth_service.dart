import 'package:appwrite/appwrite.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      throw Exception("Appwrite error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      final user = await _account.get();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        debugPrint("FCM token is null");
      }
      bool pushTargetExists = false;
      for (final target in user.targets) {
        if (target.providerId == dotenv.get("PROVIDER_ID")) {
          pushTargetExists = true;
          await _account.updatePushTarget(
            targetId: target.$id,
            identifier: fcmToken!,
          );
          break;
        }
      }
      if (!pushTargetExists) {
        await _account.createPushTarget(
          targetId: ID.unique(),
          identifier: fcmToken!,
          providerId: dotenv.get("PROVIDER_ID"),
        );
      }

      return UserModel.fromMap(user.toMap());
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        throw Exception('Invalid email or password. Please try again.');
      }
      throw Exception("Appwrite error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      throw Exception("Appwrite error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
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
      throw Exception("Appwrite error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
