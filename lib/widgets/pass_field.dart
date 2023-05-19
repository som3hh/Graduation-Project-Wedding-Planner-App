import 'package:flutter/material.dart';

class PxtFields extends StatefulWidget {
  PxtFields({
    Key? key,
    this.phintText,
    this.plabelText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String? phintText;
  final String? plabelText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  _PxtFieldsState createState() => _PxtFieldsState();
}

class _PxtFieldsState extends State<PxtFields> {
  bool _isPasswordVisible = false;

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
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextField(
          controller: widget.controller, // Use widget.controller here
          obscureText: !_isPasswordVisible,
          onChanged: widget.onChanged,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.plabelText,
            labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            hintText: widget.phintText,
            hintStyle: const TextStyle(color: Color(0xffD3D3D3)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
