import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textwidget extends StatelessWidget {
  final String name;
  const Textwidget({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return   Text(name,style: GoogleFonts.roboto(fontSize: 17,
        textStyle: Theme.of(context).textTheme.titleSmall));
  }
}
