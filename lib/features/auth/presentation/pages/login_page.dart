// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mongez_shared_code/constants/fast_theme.dart';
// import 'package:mongez_shared_code/features/auth/presentation/pages/multiple_children_wrapper.dart';
// import 'package:mongez_shared_code/features/auth/presentation/widgets/app_auth_input.dart';
// import 'package:mongez_shared_code/features/home/presentation/pages/home_page.dart';
// import 'package:mongez_shared_code/global/height_space.dart';
// import 'package:mongez_shared_code/init/runtime_variables.dart';
// import 'package:mongez_shared_code/utils/provider_calls.dart';
// import 'package:shared_code_new/shared_code_new/utils/app_routes.dart';
// import 'package:shared_code_new/shared_code_new/widgets/buttons/app_main_button.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final email = TextEditingController();
//   final password = TextEditingController();

//   void handleLogin() async {
//     try {
//       await authPF(context).login(email.text, password.text);
//       AppRoutes.pushRemoveAllBefore(
//         navigatorKey.currentContext ?? context,
//         HomePage(),
//       );
//     } catch (e) {
//       globalUtils.errorSnackbar(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var authProvider = authP(context);
//     var children2 = [
//       SizedBox(
//         width: double.infinity,
//       ),
//       // Image.asset(
//       //   'web/assets/icons/logo.png',
//       //   width: 80,
//       //   height: 80,
//       // ),
//       HeightSpace(28),
//       Text(
//         'MONGEZ',
//         style: bodyLarge(context).copyWith(
//           color: primaryColor(context),
//           fontWeight: FontWeight.bold,
//           fontSize: 60,
//         ),
//       ),
//       HeightSpace(12),
//       Text(
//         'Please sign in with your restaurant account',
//         style: bodySmall(context),
//       ),
//       HeightSpace(32),
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
//       HeightSpace(24),
//       ...mainAuthInput(
//         context: context,
//         title: 'Password',
//         hint: 'Enter your password',
//         controller: password,
//         password: true,
//         error: authProvider.passwordError,
//         enabled: !authProvider.loading,
//         textInputType: TextInputType.visiblePassword,
//         web: true,
//       ),
//       HeightSpace(18),

//       HeightSpace(24),
//       AppMainButton(
//         active: !authProvider.loading,
//         onTap: handleLogin,
//         title: 'Sign In',
//       ),
//       HeightSpace(46),
//     ];
//     return MultipleChildrenWrapper(
//       children: [
//         Container(
//           constraints: BoxConstraints(maxWidth: 400),
//           child: Column(
//             children: children2,
//           ),
//         ),
//       ],
//     );
//   }
// }
