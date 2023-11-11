import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/services/content_service.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerWdg extends StatefulWidget {
  final int audioId;
  const AudioPlayerWdg({super.key, required this.audioId});

  @override
  State<AudioPlayerWdg> createState() => _AudioPlayerWdgState();
}

class _AudioPlayerWdgState extends State<AudioPlayerWdg> {
  late AudioPlayer audioPlayer;
  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  getAudioUrl() {
    ContentService().getAudio(widget.audioId).then((value) => {
          if (value != null)
            {
              audioPlayer..setUrl(value),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    getAudioUrl();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65, // Tamaño del círculo
            height: 65, // Tamaño del círculo
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF302DA6), // Color de fondo del círculo
            ),
            child: Center(
              child: Controls(audioPlayer: audioPlayer),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width *
                0.63, // Tamaño de la barra de progreso
            child: StreamBuilder(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return const CircularProgressIndicator();
                } else {
                  return StreamBuilder(
                    stream: positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return ProgressBar(
                        barHeight: 8,
                        baseBarColor: Colors.grey[300],
                        progressBarColor: const Color(0xFF302DA6),
                        thumbColor: const Color(0xFF302DA6),
                        timeLabelTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: audioPlayer.seek,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(this.position, this.bufferedPosition, this.duration);
}

class Controls extends StatelessWidget {
  const Controls({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioPlayer.playerStateStream,
        builder: ((context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return const CircularProgressIndicator();
          } else if (playing != true) {
            return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 42.0,
                color: Colors.white,
                onPressed: audioPlayer.play);
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 42.0,
                color: Colors.white,
                onPressed: audioPlayer.pause);
          } else {
            return IconButton(
                icon: const Icon(Icons.replay),
                color: Colors.white,
                iconSize: 42.0,
                onPressed: () => audioPlayer.seek(Duration.zero));
          }
        }));
  }
}
