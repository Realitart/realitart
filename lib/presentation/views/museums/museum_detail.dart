import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/data/models/musseum_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/widgets/cards/new_obra_card.dart';
import 'package:realitart/presentation/widgets/silvers/detail_screen.dart';

class MuseumDetailScreen extends StatefulWidget {
  final MuseumModel museum;
  const MuseumDetailScreen({
    Key? key,
    required this.museum,
  }) : super(key: key);

  @override
  State<MuseumDetailScreen> createState() => _MuseumDetailScreenState();
}

class _MuseumDetailScreenState extends State<MuseumDetailScreen> {
  List<NewObraCard> lstArtworks = [];
  bool loadingArtworkData = false;

  getArtworks() {
    setState(() {
      loadingArtworkData = true;
    });
    MuseumWorkService()
        .getArtworksLst(museumId: widget.museum.id)
        .then((value) {
      List<ArtworkModel> lstArtworksData = value.cast<ArtworkModel>();
      List<NewObraCard> lstCards = [];
      for (var item in lstArtworksData) {
        lstCards.add(NewObraCard(
          artwork: item,
        ));
      }
      setState(() {
        lstArtworks = lstCards;
        loadingArtworkData = false;
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
    return Scaffold(
        body: DetailScreen(
      btnAr: false,
      imgPath: widget.museum.images,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Museo',
            style: TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.museum.name,
            style: const TextStyle(
                fontFamily: 'Gilroy_bold', fontSize: 22, color: txtBlack),
          ),
          const SizedBox(
            height: 5,
          ),
          //rich Text
          RichText(
            text: TextSpan(
              text: 'Lugar: ',
              style: const TextStyle(
                  fontFamily: 'Gilroy_bold', fontSize: 14, color: txtGrey),
              children: <TextSpan>[
                TextSpan(
                    text: widget.museum.department,
                    style: const TextStyle(
                        fontFamily: 'Gilroy_regular',
                        fontSize: 14,
                        color: txtBlack)),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              text: 'Dirección: ',
              style: const TextStyle(
                  fontFamily: 'Gilroy_bold', fontSize: 14, color: txtGrey),
              children: <TextSpan>[
                TextSpan(
                    text: widget.museum.address,
                    style: const TextStyle(
                        fontFamily: 'Gilroy_regular',
                        fontSize: 14,
                        color: txtGrey)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.museum.description,
            style: const TextStyle(
              fontFamily: 'Gilroy_regular',
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Nuevas Obras',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_medium', color: black1, fontSize: 18)),
          loadingArtworkData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lstArtworks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return lstArtworks[index];
                  }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
