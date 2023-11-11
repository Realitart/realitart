import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/views/works/widget/audio_player.dart';
import 'package:realitart/presentation/views/works/widget/commentContainer.dart';
import 'package:realitart/presentation/views/works/widget/commentInput.dart';
import 'package:realitart/presentation/widgets/silvers/detail_screen.dart';

class WorkDetailScreen extends StatefulWidget {
  final ArtworkModel artwork;
  const WorkDetailScreen({Key? key, required this.artwork}) : super(key: key);

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  bool liked = false;
  bool loadingComments = true;
  List<CommentContainer> lstCommentsWdg = [];

  void toggleHeartColor() {
    setState(() {
      liked = !liked;
    });
  }

  getComments() {
    MuseumWorkService().getComments(widget.artwork.id).then((value) => {
          for (var item in value)
            {
              lstCommentsWdg.add(CommentContainer(
                userId: item?.userId ?? 0,
                date: 'Hace unos minutos',
                comment: item?.description ?? '',
              ))
            },
          setState(() {
            loadingComments = false;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DetailScreen(
      assetId: widget.artwork.assetId,
      btnAr: true,
      imgPath: widget.artwork.images,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Obra',
            style: TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.artwork.name,
            style: const TextStyle(
                fontFamily: 'Gilroy_bold', fontSize: 24, color: txtBlack),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.artwork.categoryId.name,
            style: const TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.artwork.museumId.name,
            style: const TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 25,
          ),
          // progress bar to music player
          AudioPlayerWdg(audioId: widget.artwork.audioId),
          const SizedBox(
            height: 25,
          ),
          Text(
            widget.artwork.summary,
            style: const TextStyle(
              fontFamily: 'Gilroy_regular',
              fontSize: 16,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text('Comentarios',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_medium', color: black1, fontSize: 18)),
          CommentInput(
              func: () {
                setState(() {
                  lstCommentsWdg.clear();
                  loadingComments = true;
                });
                getComments();
              },
              artworkId: widget.artwork.id,
              imgPath: "https://cdn-icons-png.flaticon.com/512/666/666201.png"),
          loadingComments
              ? const Center(child: CircularProgressIndicator())
              : lstCommentsWdg.isEmpty
                  ? const SizedBox(
                      height: 100,
                      child: Center(child: Text('Aún no hay comentarios')))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lstCommentsWdg.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return lstCommentsWdg[index];
                      }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}

class InfoStar extends StatelessWidget {
  final double? rate;
  final bool? isYours;
  final Color? color;
  const InfoStar({
    super.key,
    this.rate,
    this.isYours = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.star, color: color ?? yellorstar, size: 40),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(
            text: '${rate ?? 0}',
            style: const TextStyle(
                fontFamily: 'Gilroy_bold', fontSize: 16, color: txtBlack),
            children: const <TextSpan>[
              TextSpan(
                  text: ' / 10',
                  style: TextStyle(
                      fontFamily: 'Lato_regular',
                      fontSize: 14,
                      color: txtGrey)),
            ],
          ),
        ),
        isYours!
            ? const Text('Tu calificación',
                style: TextStyle(
                    fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey))
            : const SizedBox(),
      ],
    );
  }
}
