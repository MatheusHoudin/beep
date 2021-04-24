import 'package:equatable/equatable.dart';

class GenericException extends Equatable implements Exception {
  @override
  List<Object> get props => ["GenericException"];
}

class WeakPasswordException extends Equatable implements Exception {
  @override
  List<Object> get props => ["WeakPasswordException"];
}

class EmailAlreadyInUseException extends Equatable implements Exception {
  @override
  List<Object> get props => ["EmailAlreadyInUseException"];
}

class InvalidEmailException extends Equatable implements Exception {
  @override
  List<Object> get props => ["InvalidEmailException"];
}

class UserNotFoundException extends Equatable implements Exception {
  @override
  List<Object> get props => ["UserNotFoundException"];
}

class WrongPasswordException extends Equatable implements Exception {
  @override
  List<Object> get props => ["WrongPasswordException"];
}

class InventoryUserNotFoundException extends Equatable implements Exception {
  @override
  List<Object> get props => ["InventoryUserNotFoundException"];
}

class InventoryUserIsAlreadyRegisteredOnInventoryException extends Equatable implements Exception {
  @override
  List<Object> get props => ["InventoryUserIsAlreadyRegisteredOnInventoryException"];
}

class InvalidInventoryProductsFileException extends Equatable implements Exception {
  final String message;

  InvalidInventoryProductsFileException({this.message});

  @override
  List<Object> get props => [this.message];
}
