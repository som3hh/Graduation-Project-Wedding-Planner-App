import 'package:flutter/material.dart';

class AgeFields extends StatelessWidget {
  const AgeFields({super.key, this.ghintText, this.glabelText});
  final String? ghintText;
  final String? glabelText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: glabelText,
                    hintText: ghintText,
                    hintStyle: const TextStyle(color: Color(0xffD3D3D3)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))))));
  }
}
