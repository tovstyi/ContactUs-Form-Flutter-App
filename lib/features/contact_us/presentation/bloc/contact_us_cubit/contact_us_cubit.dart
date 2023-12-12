import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/exceptions/failures.dart';
import '../../../domain/entities/form_entity.dart';
import '../../../domain/usecases/send_message_usecase.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final SubmitFormUseCase submitFormUseCase;

  ContactUsCubit({required this.submitFormUseCase}) : super(ContactUsInitial());

  submitForm(FormGroup form) async {
    emit(SendingMessageState());

    FormEntity formEntity = FormEntity(
        name: form.control('name').value,
        email: form.control('email').value,
        message: form.control('message').value);

    final response = await submitFormUseCase(formEntity);
    return response.fold((failure) {
      if (failure is ServerFailure) {
        return emit(
            ContactUsServerFailureState(statusCode: failure.statusCode));
      }
    }, (response) => emit(FormSuccessfullySent()));
  }

  void updateFormValidation(bool valid) {
    emit(valid ? FormValidatedState() : FormIncorrectState());
  }

  void updateFormFieldValidation(String fieldName, bool valid) {
    emit(FormFieldValidationState(fieldName: fieldName, validStatus: valid));
  }
}
