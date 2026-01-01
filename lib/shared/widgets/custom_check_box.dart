 import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
    const CustomCheckBox({super.key, required this.isEnable, required this.onChange});
  final bool isEnable;
  final ValueChanged<bool?> onChange;
   @override
   Widget build(BuildContext context) {
     return Checkbox(
         value: isEnable,
         onChanged: onChange
     );
   }
 }
