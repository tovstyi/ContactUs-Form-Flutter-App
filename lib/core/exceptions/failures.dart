import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;
  final int statusCode;

  ServerFailure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class NetworkConnectionFailure extends Failure {}
