import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_app/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());

      try {
        final response = await AuthRemoteDatasource().logout();
        response.fold(
          (error) {
            emit(_Error(error)); // Emit error state
          },
          (success) {
            emit(const _Success()); // Emit success state
            // Optionally navigate to login page if logout was successful
          },
        );
      } catch (e) {
        emit(_Error(e.toString())); // Handle any other errors
      }
    });
  }
}
