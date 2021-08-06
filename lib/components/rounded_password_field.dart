import 'package:flutter/material.dart';
import 'package:lebanon_usdt/components/text_field_container.dart';
import '../colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController ? textEditingController;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged, this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.yellowAccent,
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.visibility,
              color: secondaryColor,
            ),
            onTap: () {
              print("Hello");
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
