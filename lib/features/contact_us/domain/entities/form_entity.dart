import 'package:equatable/equatable.dart';

class FormEntity extends Equatable {
  final String name;
  final String email;
  final String message;

  const FormEntity(
      {required this.name, required this.email, required this.message});

  @override
  List<Object?> get props => [name, email, message];
}
