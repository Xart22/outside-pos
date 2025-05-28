import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_getx/app/style/app_colors.dart';

class SelectSearch extends StatelessWidget {
  final String label;
  final List<dynamic> data;
  final void Function(int?)? onChanged;
  final dynamic selectedItem;

  const SelectSearch({
    super.key,
    required this.label,
    required this.data,
    this.onChanged,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark),
        ),
        SizedBox(height: 8),
        DropdownSearch<dynamic>(
          selectedItem: selectedItem, // ✅ Set selected item
          items: (f, cs) => data.where((e) => e.name.contains(f)).toList(),
          onChanged:
              (onChanged != null) ? (value) => onChanged!(value?.id) : null,
          itemAsString: (dynamic data) => data.name,
          compareFn: (data1, data2) =>
              data1.id == data2.id, // ✅ Perbandingan berdasarkan id
          filterFn: (dynamic data, String filter) => data.name.contains(filter),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: 'Pilih $label',
              hintStyle: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.backgroundLight,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem?.name ?? '',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
            );
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Cari $label',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
