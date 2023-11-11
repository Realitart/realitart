import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> filterNames;
  final List<String> selectedFilters;
  final Function(List<String>) onFiltersSelected;

  const FilterBottomSheet({
    Key? key,
    required this.filterNames,
    required this.selectedFilters,
    required this.onFiltersSelected,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter mystate) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15.0),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Divider(
                    thickness: 4,
                    color: Color(0xFF79747E),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Filtros',
                style: TextStyle(
                  fontFamily: 'Gilroy_bold',
                  color: black1,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 15),
              // Grid view para filtros
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.filterNames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 4 / 1,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final filterName = widget.filterNames[index];
                    final isSelected =
                        widget.selectedFilters.contains(filterName);

                    return GestureDetector(
                      onTap: () {
                        mystate(() {
                          if (isSelected) {
                            widget.selectedFilters.remove(filterName);
                          } else {
                            widget.selectedFilters.add(filterName);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF302DA6)
                              : const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xFFD2D2D2)),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          filterName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy_semibold',
                            color: isSelected ? Colors.white : black1,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                  backgroundColor: const Color(0xFF302DA6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  widget.onFiltersSelected(widget.selectedFilters);
                },
                child: const Text('Filtrar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
