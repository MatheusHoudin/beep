import 'package:beep/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}
