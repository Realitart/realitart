import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/services/content_service.dart';
import 'package:realitart/presentation/views/AR/widget/screenshot_dialog.dart';
import 'package:realitart/presentation/views/home/home_screen.dart';
import 'package:realitart/presentation/widgets/dialogs/erro_alert_dialog.dart';
import 'package:share_plus/share_plus.dart';

class ARSection extends StatefulWidget {
  static String routeName = "/arView";
  final int assetId;
  const ARSection({Key? key, required this.assetId}) : super(key: key);

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  late UnityWidgetController _unityWidgetController;
  bool loadingData = true;
  String? arPath;

  @override
  void dispose() {
    // Iniciar la operación asincrónica, pero no esperarla
    close().then((_) {
      super.dispose();
    });
  }

  getAssetAR() async {
    setState(() {
      loadingData = true;
    });
    ContentService().getAsset(widget.assetId).then((value) {
      if (value != null) {
        setState(() {
          // path format: url | scale | position | rotation
          arPath =
              "${value.url} | ${value.scaleX},${value.scaleY},${value.scaleZ} | ${value.positionX},${value.positionY},${value.positionZ} | ${value.rotationX},${value.rotationY},${value.rotationZ}";
          loadingData = false;
        });
      }
    });
  }

  @override
  void initState() {
    getAssetAR().then((result) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> close() async {
    await _unityWidgetController.pause();
    await Future.delayed(const Duration(milliseconds: 200));
    _unityWidgetController.unload();
    _unityWidgetController.dispose();
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: const HomeScreen(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        child: Stack(
          children: [
            loadingData
                ? loading()
                : UnityWidget(
                    onUnityCreated: _onUnityCreated,
                    onUnityMessage: onUnityMessage,
                    onUnitySceneLoaded: onUnitySceneLoaded,
                    unloadOnDispose: true,
                    useAndroidViewSurface: false,
                    printSetupLog: false,
                    enablePlaceholder: false,
                    fullscreen: true),
            header(),
            _bottomBar()
          ],
        ),
      ),
    );
  }

  _bottomBar() {
    return Positioned(
      bottom: 15,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: primaryGrey, width: 2),
              ),
              margin: const EdgeInsets.only(bottom: 15),

              //Button Cammera
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _loadScreenshot = true;
                  });
                  // Llama a la función que toma la captura de pantalla
                  takeScreenshot();
                },
                icon: _loadScreenshot
                    ? const CircularProgressIndicator(
                        color: primaryGrey,
                      )
                    : Icon(
                        CupertinoIcons.circle_fill,
                        color: primaryGrey,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Loading Screen
  loading() {
    return const Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: black1,
          ),
          SizedBox(height: 20),
          Text(
            "Cargando",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  //Header with icon logo and Switch for AR
  Widget header() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 4.0),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      close();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: grey1.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void onUnityMessage(message) async {
    print(message.toString());
    if (message.toString() == "downloadAssetBundle") {
      downloadAssetBundle();
    }
    if (message.toString().contains("screenshotIMG")) {
      String encoded = message.toString().split(' - ')[1];
      print("Imagen de Unity recibida: $encoded");
      setState(() {
        _unityScreenshot = base64.decode(encoded);
        _loadScreenshot = false;
      });

      onTakeScreenshot();
    }
    if (message.toString().contains("Unity error: ")) {
      String error = message.toString().split('Unity error: ')[1];
      print("Error de Unity: $error");
      showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.9),
          builder: (_) => ErrorAlertDialog(
                errorMessage: error,
                func_back: () {
                  close();
                },
              )).whenComplete(() => close());
    }
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    print("Scene loaded: ${scene!.buildIndex}");
    print("Scene loaded: ${scene.name}");
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    _unityWidgetController = controller;
    selectScene('Vuforia');
  }

  void selectScene(String sceneName) async {
    _unityWidgetController.postMessage(
        'InitialController', 'LoadScene', sceneName);
  }

  void downloadAssetBundle() async {
    var path = arPath;
    _unityWidgetController.postMessage(
        "assetAR", "DownloadAssetBundleFromServer", path);
  }

  void takeScreenshot() async {
    // Llama a la función de Unity que toma la captura de pantalla
    _unityWidgetController.postMessage(
      "assetAR",
      'TakeScreenshot',
      '',
    );
  }

  late Uint8List _unityScreenshot;
  bool _loadScreenshot = false;
  File file = File('');
  List<XFile> filesToShare = <XFile>[];
  final GlobalKey _globalKey = GlobalKey();
  //Function to take screenshot and share image
  Future<void> onTakeScreenshot() async {
    _unityWidgetController.pause();

    await showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.9),
        builder: (_) => ScreenshotDialog(
              globalKey: _globalKey,
              unityScreenshot: _unityScreenshot,
              xFunction: () {
                _unityWidgetController.resume();
              },
              saveFunction: () {
                _unityWidgetController.resume();
              },
              shareFunction: () {
                _unityWidgetController.resume();
              },
            )).whenComplete(() => _unityWidgetController.resume());
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(255, 255, 255, 1.0),
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
