import 'package:flutter/material.dart';

Widget spaceVertical(double size) {
  return SizedBox(
    height: size,
  );
}

Widget spaceHorizontal(double size) {
  return SizedBox(
    width: size,
  );
}

Widget noDataFound({String message = "No Data Found!"}) {
  return Center(
    child: Text(message),
  );
}

void showToast({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
