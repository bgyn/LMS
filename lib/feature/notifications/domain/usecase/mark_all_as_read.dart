import 'package:fpdart/fpdart.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/usecase/usecase.dart';
import 'package:lms/feature/notifications/domain/repository/notifications_repository.dart';

class MarkAllAsRead extends UseCase<void, void> {
  final NotificationRepository _notificationRepository;
  MarkAllAsRead(this._notificationRepository);
  @override
  Future<Either<Failure, void>> call(void params) async {
    return _notificationRepository.markAsRead();
  }
}
