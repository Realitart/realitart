import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/musseum_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/widgets/bottomsheets/filter_bottomsheet.dart';
import 'package:realitart/presentation/widgets/cards/museos_card.dart';
import 'package:realitart/presentation/widgets/screenBase/screen_base.dart';
import 'package:realitart/presentation/widgets/searchBar/searchBar.dart';

class MuseumsScreen extends StatefulWidget {
  const MuseumsScreen({Key? key}) : super(key: key);

  @override
  State<MuseumsScreen> createState() => _MuseumsScreenState();
}

class _MuseumsScreenState extends State<MuseumsScreen> {
  List<MuseoCard> lstMuseos = [];
  List<MuseoCard> filteredMuseos = [];
  List<String> selectFilters = [];
  List<String> filterNames = [];
  bool loadingData = false;
  final TextEditingController _searchController = TextEditingController();

  getMusseums() {
    setState(() {
      loadingData = true;
    });
    MuseumWorkService().getMuseumsLst().then((value) {
      List<MuseumModel> lstMuseums = value.cast<MuseumModel>();
      List<MuseoCard> lstCards = [];
      for (var item in lstMuseums) {
        filterNames.add(item.department);

        lstCards.add(MuseoCard(
          museum: item,
        ));
      }
      filterNames = filterNames.toSet().toList();
      setState(() {
        lstMuseos = lstCards;
        filteredMuseos = List.from(lstMuseos);
        loadingData = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getMusseums();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text('Museos',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Gilroy_bold', color: black1, fontSize: 28)),
          ),
          CustomSearchBar(
            searchController: _searchController,
            onSearchTextChanged: _onSearchTextChanged,
            onFilterPressed: _onFilterPressed,
            filtersLen: selectFilters.length.toString(),
          ),
          nuevosMuseos(context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget nuevosMuseos(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.73,
            child: loadingData
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: filteredMuseos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return filteredMuseos[index];
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      filteredMuseos = lstMuseos.where((museo) {
        final title = museo.museum.name.toLowerCase();
        final searchLower = searchText.toLowerCase();
        return title.contains(searchLower);
      }).toList();
    });
  }

  _filterByDepartment(List<String> selectFilters) {
    if (selectFilters.isEmpty) {
      setState(() {
        filteredMuseos = lstMuseos;
      });
    } else {
      setState(() {
        filteredMuseos = lstMuseos.where((museum) {
          final title = museum.museum.department.toLowerCase();
          return selectFilters
              .any((filter) => title.contains(filter.toLowerCase()));
        }).toList();
      });
    }
  }

  void _onFilterPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return FilterBottomSheet(
          filterNames: filterNames,
          selectedFilters: selectFilters,
          onFiltersSelected: (List<String> selectedFilters) {
            _filterByDepartment(selectedFilters);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
