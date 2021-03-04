import 'package:equatable/equatable.dart';

class GenericException extends Equatable implements Exception {
  final String message;

  GenericException({this.message});

  @override
  List<Object> get props => [this.message];
}

class WeakPasswordException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class EmailAlreadyInUseException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class InvalidEmailException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}
