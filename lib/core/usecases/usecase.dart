import 'package:dartz/dartz.dart';

import '../exceptions/failures.dart';

abstract class UseCase<Type, FormEntity> {
  Future<Either<Failure, void>> call(FormEntity formEntity);
}
