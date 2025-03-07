import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSuccessSnackBar(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.success(
      message: "Good job, your release is successful. Have a nice day",
    ),
  );
}
