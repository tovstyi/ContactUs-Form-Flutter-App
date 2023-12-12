import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../bloc/contact_us_cubit/contact_us_cubit.dart';
import 'lock_icon.dart';

class CustomReactiveTextField extends StatefulWidget {
  const CustomReactiveTextField(
      {super.key,
      required this.form,
      required this.validationMessages,
      required this.hintText,
      required this.controlName});

  final String controlName;
  final String hintText;
  final dynamic validationMessages;
  final dynamic form;

  @override
  State<CustomReactiveTextField> createState() =>
      _CustomReactiveTextFieldState();
}

class _CustomReactiveTextFieldState extends State<CustomReactiveTextField> {
  late bool validStatus = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: BlocListener<ContactUsCubit, ContactUsState>(
          listener: (context, state) {
            if (state is FormFieldValidationState &&
                widget.controlName == state.fieldName) {
              validStatus = state.validStatus;
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 2,
                  child: BlocBuilder<ContactUsCubit, ContactUsState>(
                    builder: (context, state) {
                      return LockIcon(lockStatus: validStatus);
                    },
                  )),
              Flexible(
                flex: 6,
                child: ReactiveTextField(
                  onChanged: (control) {
                    context.read<ContactUsCubit>().updateFormFieldValidation(
                        widget.controlName,
                        widget.form.control(widget.controlName).valid);
                  },
                  formControl: widget.form.control(widget.controlName),
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3))),
                  validationMessages: widget.validationMessages,
                ),
              )
            ],
          )),
    );
  }
}
