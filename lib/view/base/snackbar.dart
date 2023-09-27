
import 'package:flutter/material.dart';

import '../../helper/responsivehelper.dart';
import '../../utill/dimensions.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final _width = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(key: UniqueKey(), content: Text(message),
      margin: ResponsiveHelper.isDesktop(context) ?  EdgeInsets.only(
        right: _width * 0.75, bottom: Dimensions.PADDING_SIZE_LARGE, left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ) : const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      behavior: SnackBarBehavior.floating ,
      dismissDirection: DismissDirection.down,
      backgroundColor: isError ? Colors.red : Colors.green)
  );
}