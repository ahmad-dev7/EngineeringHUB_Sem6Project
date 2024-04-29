import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_radius.dart';

class KSearchDropDown extends StatefulWidget {
  final String buttonHint, searchHint;
  final List<String> itemsList;
  final bool? hideSearch;
  final bool? changeBorder;
  final String? selectedValue;
  final Function(String)? validate;
  final Function(String) onSelect;
  const KSearchDropDown({
    super.key,
    required this.buttonHint,
    required this.searchHint,
    required this.itemsList,
    required this.onSelect,
    this.hideSearch,
    this.validate,
    this.changeBorder,
    this.selectedValue,
  });

  @override
  State<KSearchDropDown> createState() => _KSearchDropDownState();
}

class _KSearchDropDownState extends State<KSearchDropDown> {
  var searchController = TextEditingController();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      validator: (val) => widget.validate != null
          ? widget.validate!(val as String? ?? '')
          : null,
      items: menuItems(widget.itemsList, context),
      value: widget.selectedValue ?? selectedValue,
      hint: KMyText(widget.buttonHint, color: Theme.of(context).hintColor),
      onChanged: (value) {
        setState(() => selectedValue = value as String);
        widget.onSelect(value as String);
      },
      style: const TextStyle(overflow: TextOverflow.ellipsis),
      //* To fit long text inside button
      isExpanded: true, isDense: true,
      //* Dropdown sheet style
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: kRadius(),
        ),
      ),
      //* Menu items style
      menuItemStyleData: const MenuItemStyleData(height: 50),
      //* Search textfield
      dropdownSearchData: widget.hideSearch == true
          ? hideSearch()
          : DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                margin: const EdgeInsets.all(8),
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.5),
                      hintText: widget.searchHint,
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value.toString().toLowerCase().contains(
                      searchValue.toLowerCase(),
                    );
              },
            ),
    );
  }
}

menuItems(List<String> itemsList, BuildContext context) {
  return itemsList
      .map(
        (item) => DropdownMenuItem(
          value: item,
          child:
              KMyText(item, color: Theme.of(context).colorScheme.onBackground),
        ),
      )
      .toList();
}

DropdownSearchData<String>? hideSearch() {
  return const DropdownSearchData(
    searchInnerWidgetHeight: 0,
    searchInnerWidget: SizedBox(),
  );
}
