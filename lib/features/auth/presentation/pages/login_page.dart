   import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';
import 'package:food_rail/core/routes/app_pages.dart';
import 'package:food_rail/core/utils/app_strings.dart';
import 'package:food_rail/core/utils/custom_text_styles.dart';
import 'package:food_rail/core/utils/diamensions_file.dart';
import 'package:food_rail/features/auth/presentation/controller/auth_controller.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';
import 'package:food_rail/shared/widgets/custom_check_box.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';
import 'package:food_rail/shared/widgets/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/fixed_logo.dart';

class LoginPage extends StatelessWidget {
      LoginPage({super.key});


     final authController = Get.find<AuthController>();

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         body: SingleChildScrollView(
           child: SafeArea(child: Container(
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
                   AppStrings.login,
                   style: CustomTextStyles.getLonginTitle() ,
                 ),
                 CustomText(
                   AppStrings.loginDescription,
                   style: CustomTextStyles.getLonginDescription() ,
                 ),
                 SizedBox(
                   height: Diamensions.topMargin,
                 ),
                 CustomTextFormField(
                  type: TextFieldType.email,
                 ),
                 SizedBox(
                   height: Diamensions.spaceBetweenTextField,
                 ),
                 CustomTextFormField(
                   type: TextFieldType.password,
                 ),
                 SizedBox(
                   height: Diamensions.spaceBetweenTextField * 2,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         Obx((){
                           return CustomCheckBox(isEnable: authController.isAdmin, onChange: (value) => authController.changeIsAdmin(value!));
                         }),
                         CustomText("Admin",style: CustomTextStyles.getLonginDescription(),),
                       ],
                     ),

                     Container(
                       alignment: Alignment.centerRight,
                       child: CustomButton(
                         onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                         type: ButtonType.text,
                         text: AppStrings.forgotPassword,
                       ),
                     ),
                   ],
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
                     text: AppStrings.login,
                   );
                 }),

                 SizedBox(
                   height: Diamensions.spaceBetweenTextField ,
                 ),
                 Obx((){
                   return authController.isAdmin ? SizedBox.shrink():  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     spacing: 7,
                     children: [
                       CustomText(
                         AppStrings.doNotHaveAccount,
                         style: CustomTextStyles.getLonginDescription(),
                       ),
                       CustomButton(
                         onPressed: () => Get.toNamed(AppRoutes.signUp),
                         type: ButtonType.text,
                         text: AppStrings.signUp,
                         foregroundColor: AppColors.primaryColor,
                       )

                     ],
                   );
                 })
                ,
               ],
             ),
           )),
         ),
       );
     }
   }
