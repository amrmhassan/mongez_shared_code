// ignore_for_file: invalid_use_of_visible_for_testing_member, depend_on_referenced_packages, implementation_imports

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_options.dart';
import 'package:shared_code_new/shared_code_new/constants/styles.dart';
import 'package:shared_code_new/shared_code_new/widgets/buttons/button_wrapper.dart';

class ImagePickingWidget extends StatelessWidget {
  final XFile? pickedImage;
  final String? imageLink;
  final Function(XFile pickedFile)? onPick;
  final double? radius;
  final String? placeHolderPath;
  final double? pickMaxWidth;
  final double? pickMaxHeight;
  final Widget? nonPickedWidget;
  final Color? color;
  final double? borderRadius;
  final double? width;
  final double? height;

  const ImagePickingWidget({
    super.key,
    this.pickedImage,
    required this.imageLink,
    this.onPick,
    this.radius,
    this.placeHolderPath,
    this.pickMaxWidth,
    this.pickMaxHeight,
    this.nonPickedWidget,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
  });

  void handlePickImage(Function(XFile pickedFile)? onPick) async {
    var res = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.gallery,
      options: ImagePickerOptions(
        maxHeight: pickMaxHeight ?? 96 * 1.5,
        maxWidth: pickMaxWidth ?? 96 * 1.5,
      ),
    );
    if (res == null) return;
    onPick!(res);
  }

  double placeholderWidth(double rad) {
    if (24 > rad) {
      return rad / 2;
    } else {
      return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    double rad = radius ?? 96;
    return ButtonWrapper(
      onTap: onPick == null ? null : () => handlePickImage(onPick),
      width: width ?? rad,
      height: height ?? rad,
      borderRadius: borderRadius ?? 1000,
      child: pickedImage != null
          ? imageFileViewer()
          : imageLink == null
              ? nonPickedWidget ??
                  Container(
                    width: rad,
                    height: rad,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(
                        width: 1,
                        color: color ?? secondaryColor(context),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        placeHolderPath == null
                            ? Icon(
                                Icons.person,
                                color: color ?? secondaryColor(context),
                                size: rad / 2,
                              )
                            : Image.asset(
                                placeHolderPath!,
                                width: placeholderWidth(rad),
                                height: placeholderWidth(rad),
                                color: hintColor(context),
                              ),
                      ],
                    ),
                  )
              : CachedNetworkImage(
                  imageUrl: imageLink!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
    );
  }

  Image imageFileViewer() {
    if (kIsWeb) {
      return Image.network(
        pickedImage!.path,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(pickedImage!.path),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
