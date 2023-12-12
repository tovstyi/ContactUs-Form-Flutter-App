import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/form_entity.dart';

abstract class RemoteDatasource {
  /// calls the http://${apiUrl}
  ///
  /// Throws a [ServerException] for all errors code.
  Future<void> submitForm(FormEntity formParams);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final Dio dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
    ),
  );

  final Connectivity connectivity = Connectivity();

  isConnectedToNetwork() async {
    return await connectivity.checkConnectivity() != ConnectivityResult.none;
  }

  @override
  Future<void> submitForm(FormEntity formParams) async {
    try {
      await dio.post(
        apiUrl,
        data: <String, String>{
          'name': formParams.name,
          'email': formParams.email,
          'message': formParams.message
        },
      );
    } on DioException catch (e) {
      if (e.response == null || e.response!.statusCode! != 201) {
        throw ServerException(
            message: e.response!.statusMessage!,
            statusCode: e.response!.statusCode!);
      }
    }
  }
}
