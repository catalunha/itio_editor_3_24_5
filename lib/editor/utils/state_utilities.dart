import 'package:flutter_bloc/flutter_bloc.dart' show Cubit, BlocBase;

enum StateStatus {
  initial,
  success,
  loading,
  failure,
}

extension StateStatusIs on StateStatus {
  bool get isInitial => this == StateStatus.initial;
  bool get isSuccess => this == StateStatus.success;
  bool get isLoading => this == StateStatus.loading;
  bool get isFailure => this == StateStatus.failure;
}

extension CubitExt<T> on Cubit<T> {
  void emitSafe(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}

extension BlocExt<T> on BlocBase<T> {
  void emitSafe(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}
