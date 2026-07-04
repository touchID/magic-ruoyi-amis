import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class GlobalDialog {
  static void showDialogWithStyledMessage({
    required String message,
    required List<String> buttonTextList,
    required List<bool> buttonMainStyleList,
    required List<Function> onPressedList,
    bool isVerticalButton = false,
  }) {
    SmartDialog.show(
      useSystem: true,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: buttonTextList.asMap().entries.map((entry) {
            int index = entry.key;
            String text = entry.value;
            bool isMainStyle = buttonMainStyleList[index];
            return TextButton(
              onPressed: () => onPressedList[index](),
              child: Text(
                text,
                style: TextStyle(
                  color: isMainStyle ? const Color(0xFF409EFF) : Colors.grey,
                  fontWeight: isMainStyle ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}