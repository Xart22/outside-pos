import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            controller.clear();
            onChanged('');
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
