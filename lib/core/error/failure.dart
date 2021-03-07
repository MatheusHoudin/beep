import 'package:beep/core/constants/texts.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String title;
  final String message;

  Failure(this.title, this.message);
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure() : super(genericErrorMessageTitle, noInternetConnectionError);

  @override
  List<Object> get props => [];
}

class WeakPasswordFailure extends Failure {
  final String title;
  final String message;

  WeakPasswordFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class EmailAlreadyInUseFailure extends Failure {
  final String title;
  final String message;

  EmailAlreadyInUseFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class InvalidNameFailure extends Failure {
  final String title;
  final String message;

  InvalidNameFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class InvalidEmailFailure extends Failure {
  final String title;
  final String message;

  InvalidEmailFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class GenericFailure extends Failure {
  final String title;
  final String message;

  GenericFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class WrongPasswordFailure extends Failure {
  final String title;
  final String message;

  WrongPasswordFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}

class UserNotFoundFailure extends Failure {
  final String title;
  final String message;

  UserNotFoundFailure({this.message, this.title}) : super(title, message);

  @override
  List<Object> get props => [message, title];
}
