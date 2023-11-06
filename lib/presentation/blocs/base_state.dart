import 'package:equatable/equatable.dart';

class BaseBloc extends Equatable {
  final String _msgError;
  final bool _isShowLoading;
  final int _currentPage;
  final bool _isNextPetition;

  const BaseBloc({
    required String msgError,
    required bool isShowLoading,
    required int currentPage,
    required bool isNextPetition,
  })  : _msgError = msgError,
        _isShowLoading = isShowLoading,
        _currentPage = currentPage,
        _isNextPetition = isNextPetition;

  String get error => _msgError;
  bool get isLoading => _isShowLoading;
  bool get isError => _msgError != '';
  int get page => _currentPage;
  bool get isNext => _isNextPetition;

  @override
  List<Object?> get props =>
      [_msgError, _isShowLoading, _isNextPetition, _currentPage];
}
