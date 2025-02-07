import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/feature/notifications/data/source/remote/notification_api_service.dart';
import 'package:lms/feature/notifications/domain/model/notification_model.dart';
import 'package:lms/feature/notifications/domain/repository/notifications_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationApiService _apiService;
  NotificationRepositoryImpl(this._apiService);
  @override
  Future<Either<Failure, List<NotificationModel>>> fetchNotification() async {
    try {
      final result = await _apiService.fetchNotification();
      return right(result);
    } catch (err) {
      return left(ServerFailure(err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({String? id}) async {
    try {
      id == null
          ? await _apiService.markAsRead(id!)
          : await _apiService.markAllAsRead();
      return right(null);
    } catch (err) {
      return left(ServerFailure(err.toString()));
    }
  }
}
