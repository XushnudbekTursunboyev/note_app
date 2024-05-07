
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(bool value) onChange;
  const SearchWidget({super.key, required this.hint, required this.controller, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            EasyDebounce.debounce(
                'my-debouncer',
                const Duration(milliseconds: 500),
                    () => onChange(value.isNotEmpty)
            );
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(Icons.search_rounded),
            hintStyle: GoogleFonts.mulish(
                color: const Color(0xFF949CA9),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  color: Color(0xFF949CA9)),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
        )
      ],
    );
  }
}
