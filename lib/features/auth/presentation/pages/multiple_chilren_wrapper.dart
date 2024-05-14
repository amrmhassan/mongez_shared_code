// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:shared_code/shared_code/helper/responsive.dart';

// class MultipleChildrenWrapper extends StatelessWidget {
//   final List<Widget> children;
//   final AppBar? appBar;
//   final CrossAxisAlignment? crossAxisAlignment;
//   final MainAxisAlignment? mainAxisAlignment;
//   final EdgeInsets? padding;
//   final bool scroll;
//   const MultipleChildrenWrapper({
//     super.key,
//     required this.children,
//     this.appBar,
//     this.crossAxisAlignment,
//     this.mainAxisAlignment,
//     this.padding,
//     this.scroll = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var container = Container(
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
//       height: appBar == null
//           ? Responsive.getHeight(context)
//           : Responsive.getCleanHeight(context),
//       child: Column(
//         mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
//         crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: double.infinity),
//           ...children,
//         ],
//       ),
//     );
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       extendBody: true,
//       appBar: appBar,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           child: scroll
//               ? SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: container,
//                 )
//               : container,
//         ),
//       ),
//     );
//   }
// }
