import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/models/test_model.dart';
import 'package:realitart/data/models/test_response_model.dart' as testComplete;
import 'package:realitart/data/models/test_response_model.dart';
import 'package:realitart/data/services/test_service.dart';
import 'package:realitart/presentation/widgets/dialogs/info_dialog.dart';
import 'package:realitart/presentation/widgets/radio_buttons.dart';

class TestDetailScreen extends StatefulWidget {
  final TestModel? test;
  const TestDetailScreen({Key? key, this.test}) : super(key: key);

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  int? QyAIndex = 0;
  TestResponseModel? response;

  nextQuestion() {
    //validate if the user has selected an option and if it is the last question
    if (QyAIndex == widget.test!.questionsAnsAnswers.length - 1) {
      //validate if the user has answered all the questions
      if (response!.questionsAnsAnswers.length !=
          widget.test!.questionsAnsAnswers.length) {
        showSnackBar('Debes responder todas las preguntas');
        return;
      }
      showDialog(
          context: context,
          builder: (BuildContext context) => InfoDialog(
                title: '¿Seguro que deseas enviar el test?',
                message:
                    'Recuerda que una vez enviado no podrás volver a realizarlo',
                closeOption: true,
                onPressed: () {
                  sendTest().then((value) {
                    if (value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => InfoDialog(
                                title: 'Test enviado',
                                message: 'Tu test ha sido enviado exitosamente',
                                closeOption: false,
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamed('/home');
                                },
                                icon: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: txtGrey,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Icon(Icons.check_rounded,
                                      color: Colors.white, size: 100),
                                ),
                              ));
                    }
                    Navigator.pop(context);
                  });
                },
                icon:
                    //Circle whith question icon
                    Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: txtGrey, borderRadius: BorderRadius.circular(100)),
                  child: const Icon(Icons.help_outline_rounded,
                      color: Colors.white, size: 50),
                ),
              ));
      return;
    }
    setState(() {
      QyAIndex = QyAIndex! + 1;
    });
  }

  previousQuestion() {
    //validaet if it is the first question
    if (QyAIndex == 0) {
      showSnackBar('Esta es la primera pregunta');
      return;
    }
    setState(() {
      QyAIndex = QyAIndex! - 1;
    });
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF302DA6),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  setQyA(int questionId, int answerId) {
    testComplete.QuestionsAnsAnswer qya = testComplete.QuestionsAnsAnswer(
        questionId: questionId, answerId: answerId);
    //validate if the response is null
    if (response == null) {
      response = TestResponseModel(
          id: widget.test!.id,
          questionsAnsAnswers: [qya],
          expiration: DateTime.now(),
          start: DateTime.now());
      return;
    }
    //validate if the question is already answered and update it or add it
    if (response!.questionsAnsAnswers
        .any((element) => element.questionId == questionId)) {
      response!.questionsAnsAnswers
          .removeWhere((element) => element.questionId == questionId);
      response!.questionsAnsAnswers.add(qya);
    } else {
      response!.questionsAnsAnswers.add(qya);
    }
  }

  Future<bool> sendTest() async {
    //send the test
    TestService().sendCompleteTest(response!).then((value) {
      if (value!) {
        Navigator.pop(context);
        return true;
      } else {
        showSnackBar('Ocurrió un error al enviar el test');
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              //background image
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imgs/FondoPatron.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.6,
                          top: 10),
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Salir',
                            style: TextStyle(
                                fontFamily: 'Gilroy_regular',
                                fontSize: 16,
                                color: Color(0xFF302DA6)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.cancel,
                              color: Color(0xFF302DA6), size: 20),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.3,
                        bottom: 10),
                    child: Text(
                      widget.test!.name,
                      maxLines: 2,
                      style: const TextStyle(
                          fontFamily: 'Gilroy_bold',
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Pregunta ${QyAIndex! + 1} de ${widget.test!.questionsAnsAnswers.length}',
                      style: const TextStyle(
                          fontFamily: 'Gilroy_semibold',
                          fontSize: 16,
                          color: txtBlack),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    decoration: const BoxDecoration(
                        color: Color(0xFF302DA6),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      '${widget.test!.questionsAnsAnswers[QyAIndex!].points} ptos.',
                      style: const TextStyle(
                          fontFamily: 'Gilroy_semibold',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  widget.test!.questionsAnsAnswers[QyAIndex!].statement,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Gilroy_bold', fontSize: 18, color: black1),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
              decoration: const BoxDecoration(
                color: Colors.white,
                // Top borders border
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: CustomRadioButtons(
                  options: widget.test!.questionsAnsAnswers[QyAIndex!].answers
                      .map((e) => e.answer)
                      .toList(),
                  isVertical: true,
                  onChanged: (value) {
                    setQyA(
                        widget.test!.questionsAnsAnswers[QyAIndex!].questionId,
                        widget.test!.questionsAnsAnswers[QyAIndex!].answers
                            .where((element) => element.answer == value)
                            .first
                            .id);
                  }),
            )
          ],
        ),
        //Bottombar with 2 buttons
        bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    previousQuestion();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Color(0xFFFEDF1FF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Anterior',
                          style: TextStyle(
                              fontFamily: 'Gilroy_semibold',
                              fontSize: 16,
                              color: const Color(0xFF302DA6)),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextQuestion();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      color: const Color(0xFF302DA6),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Siguiente',
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
