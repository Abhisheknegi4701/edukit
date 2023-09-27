

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ResponsiveHelper extends StatelessWidget {

  final Widget mobile;
  final Widget tablet;

  const ResponsiveHelper({super.key,
    required this.mobile,
    required this.tablet,
  });

  static bool isMobilePhone() {
    if (!kIsWeb) {
      return true;
    }else {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMobile(context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 800 || !kIsWeb) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTablet(context) {
    final size = MediaQuery
        .of(context)
        .size
        .width;
    if (size < 1700 && size >= 800) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDesktop(context) {
    final size = MediaQuery
        .of(context)
        .size
        .width;
    if (size >= 2500) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return tablet;
        }
        else {
          return mobile;
        }
      },
    );
  }

}