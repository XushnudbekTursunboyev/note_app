

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget InputText({required String label, required String hint, required TextEditingController controller, required int maxLines}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.mulish(
          color: const Color(0xFF232638),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 0.10,
        ),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
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