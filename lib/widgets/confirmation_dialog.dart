import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class ConfirmationDialog {

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "Yes",
    String cancelText = "No",
  }) {

    return showDialog<bool>(
      context: context,

      builder: (context) {

        return AlertDialog(

          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
          ),

          title: Text(title),

          content: Text(content),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(
                  context,
                  false,
                );
              },

              child: Text(cancelText),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: redColor,
              ),

              onPressed: () {

                Navigator.pop(
                  context,
                  true,
                );
              },

              child: Text(
                confirmText,

                style:  TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}