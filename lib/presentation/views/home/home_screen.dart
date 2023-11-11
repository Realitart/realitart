import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/data/models/musseum_model.dart';
import 'package:realitart/data/models/user_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/widgets/cards/museos_card.dart';
import 'package:realitart/presentation/widgets/screenBase/screen_base.dart';

import '../../widgets/cards/new_obra_card.dart';
import '../../widgets/cards/obra_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MuseoCard> lstMuseos = [];
  bool loadingMuseumData = true;
  List<ObraCard> lstWorks = [];
  bool loadingWorksData = true;
  UserModel? user;

  getMusseums() {
    setState(() {
      loadingMuseumData = true;
    });
    MuseumWorkService().getMuseumsLst().then((value) {
      List<MuseumModel> lstMuseums = value.cast<MuseumModel>();
      List<MuseoCard> lstCards = [];
      for (var item in lstMuseums) {
        lstCards.add(MuseoCard(
          museum: item,
        ));
      }
      setState(() {
        lstMuseos = lstCards;
        loadingMuseumData = false;
      });
    });
  }

  getWorks() {
    setState(() {
      loadingWorksData = true;
    });
    MuseumWorkService().getArtworksLst(size: 6).then((value) {
      List<ArtworkModel> lstObras = value.cast<ArtworkModel>();
      List<ObraCard> lstCards = [];
      for (var item in lstObras) {
        lstCards.add(ObraCard(
          artwork: item,
        ));
      }
      setState(() {
        lstWorks = lstCards;
        loadingWorksData = false;
      });
    });
  }

  getUserData() async {
    String userData = await getPreference('user');
    var userJson = json.decode(userData);
    setState(() {
      user = UserModel.fromJson(userJson);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getMusseums();
    getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Hola ${user?.username}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'Gilroy_bold',
                    color: Colors.black,
                    fontSize: 26)),
          ),
          recomendaciones(context),
          nuevosMuseos(context),
          const SizedBox(
            height: 20,
          ),
          nuevasObras(context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  recomendaciones(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recomendaciones',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_medium', color: black1, fontSize: 18)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: loadingWorksData || lstWorks.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ObraCard(
                        artwork: lstWorks[index].artwork,
                      );
                    }),
          )
        ],
      ),
    );
  }

  nuevosMuseos(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nuevos Museos',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_medium', color: black1, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: loadingMuseumData || lstMuseos.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MuseoCard(
                        museum: lstMuseos[index].museum,
                      );
                    }),
          )
        ],
      ),
    );
  }

  nuevasObras(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nuevas Obras',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_medium', color: black1, fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          loadingWorksData || lstWorks.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NewObraCard(
                            artwork: lstWorks[index + 2].artwork);
                      }),
                )
        ],
      ),
    );
  }
}
