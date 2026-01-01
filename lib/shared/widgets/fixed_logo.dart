 import 'package:flutter/material.dart';

import '../../core/utils/app_images.dart';

class FixedLogo extends StatelessWidget {
   const FixedLogo({super.key});

   @override
   Widget build(BuildContext context) {
     return Image.asset(
       AppImages.imageLogo,
       height: 120,
       width: 120,
       fit: BoxFit.cover,
     );
   }
 }
