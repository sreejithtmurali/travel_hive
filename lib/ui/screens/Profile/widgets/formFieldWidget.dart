import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/color_constants.dart';


class Formfieldwidget extends StatelessWidget {
  final TextInputType textInputType;
  final String hintname;
  final TextEditingController controller;
  final bool isEmailField;

  const Formfieldwidget(
      {super.key,
      required this.textInputType,
      required this.hintname,
      required this.controller,
      this.isEmailField = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: ColorConstants.grey.withOpacity(  0.3),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        readOnly: isEmailField,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: hintname,
            hintStyle: GoogleFonts.roboto(
                fontSize: 17, color: ColorConstants.mainblack),
            border: InputBorder.none),
        style:
            GoogleFonts.roboto(fontSize: 17, color: ColorConstants.mainblack),
      ),
    );
  }
}
