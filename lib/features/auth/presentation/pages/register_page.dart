// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, invalid_use_of_visible_for_testing_member

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:admin_dashboard/constants/assets.dart';
// import 'package:admin_dashboard/constants/fast_theme.dart';
// import 'package:shared_code_new/shared_code_new.dart';
// import 'package:admin_dashboard/features/auth/presentation/pages/login_page.dart';
// import 'package:admin_dashboard/features/auth/presentation/pages/multiple_chilren_wrapper.dart';
// import 'package:admin_dashboard/features/home/presentation/pages/main_page_holder.dart';
// import 'package:admin_dashboard/init/runtime_variables.dart';
// import 'package:user_app/features/auth/data/datasources/email_verfication_datasource.dart';
// import 'package:user_app/features/auth/presentation/widgets/app_auth_input.dart';
// import 'package:user_app/features/auth/presentation/widgets/app_main_button.dart';
// import 'package:user_app/features/auth/presentation/widgets/user_image.dart';
// import 'package:user_app/global/height_space.dart';
// import 'package:user_app/utils/app_routes.dart';
// import 'package:user_app/utils/global_utils.dart';
// import 'package:admin_dashboard/utils/provider_calls.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final name = TextEditingController();
//   final emailVerificationDatasource = EmailVerificationDatasource();
//   File? imageFile;

//   void handlePickImage(File file) async {
//     imageFile = file;
//     setState(() {});
//   }

//   void handleRegister() async {
//     try {
//       await authPF(context).register(
//         email: email.text,
//         fullName: name.text,
//         password: password.text,
//         imageFile: imageFile,
//       );
//       await emailVerificationDatasource.sendEmailVerification();
//       AppRoutes.pushRemoveAllBefore(
//         navigatorKey.currentContext ?? context,
//         MainPageHolder(),
//       );
//     } catch (e) {
//       GlobalUtils.errorSnackbar(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var authProvider = authP(context);
//     var children2 = [
//       SizedBox(
//         width: double.infinity,
//       ),
//       VSpace(),
//       Text(
//         'Sign Up Now',
//         style: bodyLarge(context),
//       ),
//       HeightSpace(12),
//       Text(
//         'Please fill the details to create your account',
//         style: bodySmall(context),
//       ),
//       HeightSpace(32),
//       UserImage(
//         pickedImage: imageFile,
//         imageLink: null,
//         onPick: handlePickImage,
//         placeHolderPath: Assets.galleryAdd,
//       ),
//       HeightSpace(18),
//       ...mainAuthInput(
//         context: context,
//         title: 'Full Name',
//         hint: 'Enter your name',
//         controller: name,
//         error: authProvider.nameError,
//         enabled: !authProvider.loading,
//         svgIconPath: 'web/assets/svgs/profile.svg',
//         textInputType: TextInputType.name,
//       ),
//       HeightSpace(18),
//       ...mainAuthInput(
//         context: context,
//         title: 'Email',
//         hint: 'Enter your email',
//         controller: email,
//         error: authProvider.emailError,
//         enabled: !authProvider.loading,
//         svgIconPath: 'web/assets/svgs/email.svg',
//         textInputType: TextInputType.emailAddress,
//       ),
//       HeightSpace(18),
//       ...mainAuthInput(
//         context: context,
//         title: 'Password',
//         hint: 'Enter your password',
//         controller: password,
//         password: true,
//         error: authProvider.passwordError,
//         enabled: !authProvider.loading,
//         textInputType: TextInputType.visiblePassword,
//       ),
//       HeightSpace(12),
//       Row(
//         children: [
//           Text(
//             'Password must be at least 8 characters',
//             style: bodySmall(context),
//           ),
//         ],
//       ),
//       HeightSpace(24),
//       AppMainButton(
//         active: !authProvider.loading,
//         onTap: handleRegister,
//         title: 'Sign Up',
//       ),
//       HeightSpace(46),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Already have an account?',
//             style: bodySmall(context),
//           ),
//           TextButton(
//             onPressed: () {
//               AppRoutes.pushReplacement(context, LoginPage());
//               authPF(context).clearErrors();
//             },
//             child: Text(
//               'Sign in',
//               style: bodyMedium(context).copyWith(color: primaryColor(context)),
//             ),
//           )
//         ],
//       ),
//     ];
//     return MultipleChildrenWrapper(
//       children: children2,
//     );
//   }
// }
