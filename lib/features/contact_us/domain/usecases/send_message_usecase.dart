import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/contact_us_repository.dart';
import '../entities/form_entity.dart';

class SubmitFormUseCase extends UseCase<Type, FormEntity> {
  final Repository repository;

  SubmitFormUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(FormEntity formEntity) async {
    return await repository.submitForm(formEntity);
  }
}
