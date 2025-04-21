import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';


class DropdownWidget extends StatefulWidget {
  final List<String> items;
  const DropdownWidget({super.key, required this.items});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late List<String> items1;

  @override
  void initState() {
    super.initState();
    items1 = widget.items;
  }

  String? selectedTravelType;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: ColorConstants.grey.withOpacity(  0.4),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Type',
            style: GoogleFonts.b612Mono(
              fontSize: 14,
              textStyle: Theme.of(context).textTheme.displaySmall,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items1
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.roboto(
                  fontSize: 17,
                  textStyle: Theme.of(context).textTheme.displaySmall),
            ),
          ))
              .toList(),
          value: selectedTravelType,
          onChanged: (value) {
            setState(() {
              selectedTravelType = value;
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 175,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search here...',
                  hintStyle: GoogleFonts.cabinCondensed(
                      fontSize: 15,
                      textStyle: Theme.of(context).textTheme.labelSmall),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
