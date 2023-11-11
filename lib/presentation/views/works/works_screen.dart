import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/widgets/bottomsheets/filter_bottomsheet.dart';
import 'package:realitart/presentation/widgets/cards/new_obra_card.dart';
import 'package:realitart/presentation/widgets/screenBase/screen_base.dart';
import 'package:realitart/presentation/widgets/searchBar/searchBar.dart';

class WorksScreen extends StatefulWidget {
  const WorksScreen({Key? key}) : super(key: key);

  @override
  State<WorksScreen> createState() => _WorksScreenState();
}

class _WorksScreenState extends State<WorksScreen> {
  List<NewObraCard> lstObras = [];
  List<NewObraCard> filteredObras = [];
  List<String> selectFilters = [];
  List<String> filterNames = [];
  bool loadingData = true;
  final TextEditingController _searchController = TextEditingController();

  getArtworks() {
    setState(() {
      loadingData = true;
    });
    MuseumWorkService().getArtworksLst().then((value) {
      List<ArtworkModel> lstArtworks = value.cast<ArtworkModel>();
      List<NewObraCard> lstCards = [];
      for (var item in lstArtworks) {
        filterNames.add(item.categoryId.name);
        lstCards.add(NewObraCard(
          artwork: item,
        ));
      }
      filterNames = filterNames.toSet().toList();
      setState(() {
        lstObras = lstCards;
        filteredObras = List.from(lstCards);
        loadingData = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getArtworks();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text('Obras',
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
          gridObras(context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget gridObras(BuildContext context) {
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
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredObras.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return filteredObras[index];
                      },
                    )),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      filteredObras = lstObras.where((artwork) {
        final title = artwork.artwork.name.toLowerCase();
        final searchLower = searchText.toLowerCase();
        return title.contains(searchLower);
      }).toList();
    });
  }

  _filterByCategory(List<String> selectFilters) {
    if (selectFilters.isEmpty) {
      setState(() {
        filteredObras = lstObras;
      });
    } else {
      setState(() {
        filteredObras = lstObras.where((artwork) {
          final title = artwork.artwork.categoryId.name.toLowerCase();
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
            _filterByCategory(selectedFilters);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
