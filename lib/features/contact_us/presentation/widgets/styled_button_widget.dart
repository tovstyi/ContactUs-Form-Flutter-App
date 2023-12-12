import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_us_cubit/contact_us_cubit.dart';

class StyledButtonWidget extends StatefulWidget {
  const StyledButtonWidget(
      {super.key, required this.caption, required this.onPressed});

  final String caption;
  final Function? onPressed;

  @override
  State<StyledButtonWidget> createState() => _StyledButtonWidgetState();
}

class _StyledButtonWidgetState extends State<StyledButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ContactUsCubit, ContactUsState>(
            builder: (context, state) {
              return MaterialButton(
                height: 50,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: state is SendingMessageState || widget.onPressed == null
                    ? const Color.fromRGBO(152, 109, 142, 0)
                    : const Color.fromRGBO(152, 109, 142, 1),
                onPressed: () =>
                    state is SendingMessageState ? null : widget.onPressed!(),
                child: state is SendingMessageState
                    ? const CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    : Text(
                        widget.caption,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
