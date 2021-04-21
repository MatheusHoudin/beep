import 'package:equatable/equatable.dart';

class GenericException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
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

class UserNotFoundException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class WrongPasswordException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class InventoryUserNotFoundException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class InventoryUserIsAlreadyRegisteredOnInventoryException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}

class InvalidInventoryProductsFileException extends Equatable implements Exception {
  final String message;

  InvalidInventoryProductsFileException({this.message});

  @override
  List<Object> get props => [this.message];
}
