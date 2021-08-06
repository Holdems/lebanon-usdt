import 'package:flutter/material.dart';
import 'package:lebanon_usdt/components/text_field_container.dart';

import '../colors.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController ? textEditingController;
  final ValueChanged<String>? onChanged;
   const RoundedInputField(
      {Key? key,
        required this.hintText,
        this.icon = Icons.person,
        required this.onChanged,  this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Field Cannot be empty";
            }
            return null;
          },
          controller: textEditingController,
          style: TextStyle(color: Colors.white),
          onChanged: onChanged,
          cursorColor: secondaryColor,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(
                icon,
                color: secondaryColor,
              ),
              hintText: hintText,
              border: InputBorder.none),
        ));
  }
}