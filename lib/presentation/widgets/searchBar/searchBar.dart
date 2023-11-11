import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchTextChanged;
  final VoidCallback onFilterPressed;
  final String? filtersLen;

  const CustomSearchBar({
    required this.searchController,
    required this.onSearchTextChanged,
    required this.onFilterPressed,
    this.filtersLen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: onSearchTextChanged,
        cursorColor: black1,
        decoration: InputDecoration(
          hintText: 'Buscar...',
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconColor: black1,
          suffixIcon: IconButton(
            onPressed: onFilterPressed,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                // SvgPicture.asset('assets/svg/filter_icon.svg', height: 25),
                const Icon(Icons.filter_list_rounded, size: 25),
                if (filtersLen != null && filtersLen != '0')
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFF302DA6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Text(
                        filtersLen!,
                        style: const TextStyle(
                          fontFamily: 'Gilroy_semibold',
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
