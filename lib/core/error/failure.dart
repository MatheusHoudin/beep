import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoInternetConnectionFailure extends Failure {

  @override
  List<Object> get props => [];
}

class WeakPasswordFailure extends Failure {
  final String title;
  final String message;

  WeakPasswordFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}

class EmailAlreadyInUseFailure extends Failure {
  final String title;
  final String message;

  EmailAlreadyInUseFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}

class InvalidNameFailure extends Failure {
  final String title;
  final String message;

  InvalidNameFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}

class InvalidEmailFailure extends Failure {
  final String title;
  final String message;

  InvalidEmailFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}

class GenericFailure extends Failure {
  final String title;
  final String message;

  GenericFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}
