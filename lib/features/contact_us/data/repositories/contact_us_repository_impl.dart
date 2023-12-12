import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/exceptions/failures.dart';
import '../../domain/entities/form_entity.dart';
import '../datasources/remote_datasource.dart';
import 'contact_us_repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource remoteDatasource;

  final Connectivity connectivity = Connectivity();

  isConnectedToNetwork() async {
    return await connectivity.checkConnectivity() != ConnectivityResult.none;
  }

  RepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> submitForm(FormEntity formParams) async {
    if (await isConnectedToNetwork()) {
      try {
        final response = await remoteDatasource.submitForm(formParams);
        return Right<Failure, void>(response);
      } on ServerException catch (e) {
        return Left<Failure, void>(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      return Left<Failure, void>(NetworkConnectionFailure());
    }
  }
}
