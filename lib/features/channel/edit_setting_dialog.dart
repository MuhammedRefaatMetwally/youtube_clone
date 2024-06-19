// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsDialog extends StatefulWidget {
  final String identifier;
  final Function(String channelName)? onSave;
  const SettingsDialog({
    Key? key,
    required this.identifier,
    this.onSave,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(),
      title: Padding(
        padding:  EdgeInsets.only(left: 22.w, top: 8.h),
        child: Text(
          widget.identifier,
          style:  TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
      ),
      content: SizedBox(
        height: 50.h,
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "CANCEL",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "SAVE",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
