import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/params/password_reset_params.dart';
import 'package:lms/core/params/verify_otp_params.dart';
import 'package:lms/feature/password_reset/domain/usecase/reset_password.dart';
import 'package:lms/feature/password_reset/domain/usecase/send_password_reset.dart';
import 'package:lms/feature/password_reset/domain/usecase/verify_otp.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_event.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final ResetPassword _resetPassword;
  final VerifyOtp _verifyOtp;
  final SendPasswordReset _sendPasswordReset;
  PasswordResetBloc({
    required ResetPassword resetPassword,
    required VerifyOtp verifyOtp,
    required SendPasswordReset sendPasswordReset,
  })  : _resetPassword = resetPassword,
        _verifyOtp = verifyOtp,
        _sendPasswordReset = sendPasswordReset,
        super(
          PasswordInitial(),
        ) {
    on<PasswordResetSubmitted>(_onPasswordResetSubmitted);
    on<PasswordResetOtpVerify>(_onPasswordResetOtpVerify);
    on<PasswordReset>(_onPasswordReset);
    on<PasswordResetOtpResend>(_onPasswordResetOtpResend);
  }

  void _onPasswordResetSubmitted(
    PasswordResetSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(PasswordResetLoading());
    final result = await _sendPasswordReset(event.email);
    result.fold(
      (failure) => emit(PasswordResetRequestFailure(failure.errorMessage)),
      (success) => emit(PasswordResetRequestSuccess()),
    );
  }

  void _onPasswordResetOtpVerify(
    PasswordResetOtpVerify event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(PasswordResetLoading());
    final result =
        await _verifyOtp(VerifyOtpParams(email: event.email, otp: event.otp));
    result.fold(
      (failure) => emit(PasswordOtpVerifyFailure(failure.errorMessage)),
      (success) => emit(PasswordOtpVerifySuccess()),
    );
  }

  void _onPasswordReset(
    PasswordReset event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(PasswordResetLoading());
    final result = await _resetPassword(
        PasswordResetParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(PasswordResetFailure(failure.errorMessage)),
      (success) => emit(PasswordResetSuccess()),
    );
  }

  void _onPasswordResetOtpResend(
    PasswordResetOtpResend event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(PasswordResetLoading());
    final result = await _sendPasswordReset(event.email);
    result.fold(
      (failure) => emit(PasswordResetRequestFailure(failure.errorMessage)),
      (success) => emit(PasswordResetRequestSuccess()),
    );
  }
}
