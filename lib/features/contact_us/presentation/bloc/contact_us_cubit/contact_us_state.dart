part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class SendingMessageState extends ContactUsState {}

class FormValidatedState extends ContactUsState {}

class FormIncorrectState extends ContactUsState {}

class FormFieldValidationState extends ContactUsState {
  final String fieldName;
  final bool validStatus;

  FormFieldValidationState(
      {required this.fieldName, required this.validStatus});
}

class ContactUsServerFailureState extends ContactUsState {
  final int statusCode;

  ContactUsServerFailureState({required this.statusCode});
}

class FormSuccessfullySent extends ContactUsState {}
