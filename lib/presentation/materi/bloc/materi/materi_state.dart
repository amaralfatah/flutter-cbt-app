part of 'materi_bloc.dart';

@freezed
class MateriState with _$MateriState {
  const factory MateriState.initial() = _Initial;
  const factory MateriState.loading() = _Loading;
  const factory MateriState.success(MateriResponseModel materi) = _Success;
  const factory MateriState.error(String message) = _Error;
}
