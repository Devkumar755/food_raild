 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_styles.dart';
import '../../../../core/utils/diamensions_file.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/fixed_logo.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends StatelessWidget {
    RegisterPage({super.key});

    final authController = Get.find<AuthController>();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(child: Container(
         alignment: Alignment.center,
         padding: EdgeInsets.symmetric(horizontal: Diamensions.globalHorizontalPadding * 2),
         child: Column(
           children: [
             SizedBox(
               height: Diamensions.topMargin,
             ),
             FixedLogo(),
             SizedBox(
               height: Diamensions.topMargin,
             ),
             CustomText(
               AppStrings.signUp,
               style: CustomTextStyles.getLonginTitle() ,
             ),
             CustomText(
               AppStrings.signUpDescription,
               style: CustomTextStyles.getLonginDescription() ,
             ),
             SizedBox(
               height: Diamensions.topMargin,
             ),
             CustomTextFormField(
               type: TextFieldType.name,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField,
             ),
             CustomTextFormField(
               type: TextFieldType.email,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField,
             ),
             CustomTextFormField(
               type: TextFieldType.phoneNumber,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField,
             ),
             CustomTextFormField(
               type: TextFieldType.address,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField,
             ),
             CustomTextFormField(
               type: TextFieldType.password,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField ,
             ),
             CustomTextFormField(
               type: TextFieldType.confirmPassword,
             ),
             SizedBox(
               height: Diamensions.spaceBetweenTextField ,
             ),
             Obx((){
               return     CustomButton(
                 width: double.infinity,
                 onPressed: () {},
                 isLoading: authController.isLoading,
                 type: ButtonType.elevated,
                 text: AppStrings.signUp,
               );
             }),
             SizedBox(
               height: Diamensions.spaceBetweenTextField ,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               spacing: 7,
               children: [
                 CustomText(
                   AppStrings.alreadyHaveAccount,
                   style: CustomTextStyles.getLonginDescription(),
                 ),
                 CustomButton(
                   onPressed: () => Get.toNamed(AppRoutes.login),
                   type: ButtonType.text,
                   text: AppStrings.login,
                   foregroundColor: AppColors.primaryColor,
                 )
               ],
             ),
           ],
         ),
       )),
     );
   }
 }
