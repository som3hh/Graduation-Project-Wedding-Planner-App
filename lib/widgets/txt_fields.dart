import 'package:flutter/material.dart';

class TxtFields extends StatelessWidget {
  TxtFields({
    Key? key,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xffF7C8E0), // Customize the highlight color here
          width: 2,
        ),
        // Remove the boxShadow
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 20),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xffD3D3D3)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
