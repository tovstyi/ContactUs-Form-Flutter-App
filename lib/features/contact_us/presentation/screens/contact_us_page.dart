import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../injection_container.dart';
import '../bloc/contact_us_cubit/contact_us_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/styled_button_widget.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final FormGroup contactUsForm = FormGroup({
    'name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'message': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  Widget build(BuildContext pageContext) {
    double width = MediaQuery.of(pageContext).size.width;

    return BlocProvider<ContactUsCubit>(
      create: (mainContext) => sl<ContactUsCubit>(),
      child: BlocListener<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          print(state);
          if (state is FormSuccessfullySent) {
            SnackBar resultSnackBar = const SnackBar(
              content: Text('Your form was successfuly sent.'),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(pageContext).showSnackBar(resultSnackBar);
          } else if (state is ContactUsServerFailureState) {
            SnackBar resultSnackBar = SnackBar(
              content: Text(
                  'Some problems occured. Failed to send your form.${state.statusCode}'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(pageContext).showSnackBar(resultSnackBar);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Image.asset(
              'assets/images/header/left-arrow.png',
              scale: 1.4,
            ),
            title: const Text('Contact us'),
            centerTitle: true,
            titleTextStyle: const TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: Column(
              children: <Widget>[
                const Spacer(),
                Flexible(
                  flex: 7,
                  child: ReactiveForm(
                    formGroup: contactUsForm,
                    child: Column(
                      children: <Widget>[
                        CustomReactiveTextField(
                          form: contactUsForm,
                          controlName: 'name',
                          hintText: 'Name',
                          validationMessages: {
                            'required': (error) => 'Please enter your name'
                          },
                        ),
                        const Spacer(),
                        CustomReactiveTextField(
                          form: contactUsForm,
                          hintText: 'Email',
                          validationMessages: {
                            'required': (error) => 'Please enter your email',
                            'email': (error) =>
                                'Incorrect email format. Please enter correct one.'
                          },
                          controlName: 'email',
                        ),
                        const Spacer(),
                        CustomReactiveTextField(
                          form: contactUsForm,
                          hintText: 'Message',
                          validationMessages: {
                            'required': (error) => 'Please enter your message'
                          },
                          controlName: 'message',
                        ),
                        const Spacer(),
                        Flexible(child: ReactiveFormConsumer(
                          builder: (context, form, child) {
                            return StyledButtonWidget(
                                caption: 'Send',
                                onPressed: contactUsForm.valid
                                    ? () async {
                                        if (contactUsForm.valid) {
                                          contactUsForm.unfocus();
                                          await context
                                              .read<ContactUsCubit>()
                                              .submitForm(contactUsForm);
                                        }
                                      }
                                    : null);
                          },
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
