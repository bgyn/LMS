import 'package:fpdart/fpdart.dart';
import 'package:lms/shared/core/faliure/faliure.dart';
import 'package:lms/shared/core/usecase/usecase.dart';
import 'package:lms/client/feature/notifications/domain/repository/notifications_repository.dart';

class MarkAsRead extends UseCase<void, String> {
  final NotificationRepository _notificationRepository;
  MarkAsRead(this._notificationRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return _notificationRepository.markAsRead(id: params);
  }
}
