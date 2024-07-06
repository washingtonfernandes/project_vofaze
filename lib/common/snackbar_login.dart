import "package:flutter/material.dart";

showSnackbar({
  required BuildContext context,
  required String texto,
  bool iserro = true,
}) {
  SnackBar snackBar = SnackBar(
      content: Text(texto),
      backgroundColor: (iserro) ? Colors.red : Colors.green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
      ));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
