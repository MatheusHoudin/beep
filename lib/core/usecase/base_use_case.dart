import 'package:beep/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AsyncBaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class FutureBaseUseCase<Params> {
  Future call(Params params);
}

abstract class BaseUseCase<Type, Params> {
  Type call(Params params);
}
