




import 'package:flutter/material.dart';

class AddTaskItem extends StatelessWidget {
  late String textTitle;
  late String hintTitle;
   TextEditingController? controller;
  void Function()? onPressed;
  IconData? suffixIcon;
  bool readOnly;
  String? Function(String?)? validator;
  AddTaskItem(
      {super.key,
        required this.textTitle,
        required this.hintTitle,
         this.controller,
        this.onPressed,
        this.suffixIcon,
        this.readOnly=false,
        this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 15,
        ),


        TextFormField(
          validator: validator,
          style: Theme.of(context).textTheme.displayMedium,
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintTitle,
            suffixIcon: suffixIcon != null
                ? IconButton(
                onPressed: onPressed,
                icon: Icon(suffixIcon))
                : null,
          ),
        )
      ],
    );
  }
}




