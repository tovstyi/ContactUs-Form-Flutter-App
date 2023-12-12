import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../../domain/entities/form_entity.dart';

abstract class Repository {
  Future<Either<Failure, void>> submitForm(FormEntity formParams);
}
