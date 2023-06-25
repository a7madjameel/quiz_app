import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../constants.dart';
import '../modules/timer_utils.dart';
import '../modules/true_false/quizBrain.dart';
import '../widgets/my_outline_btn.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  const TrueFalseQuiz({super.key});

  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  TimerUtils? timerInQuiz;
  double? loadingValue = 1;
  int? timerValue = 10;

  bool nextBtnAvailable = false;
  bool allChoicesBtn = true;

  int questionNumber = 1;
  int questionsCount = 0;
  int correctAnswersCount = 0;

  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  int counter = 10;
  bool isVisible = false;

  int? score ;

  @override
  void initState() {
    questionsCount = quizBrain.getQuestionCount();
    startTimer();
    super.initState();
  }

  void checkAnswer(bool userChoice) {
    cancelTimer();
    setState(() {
      nextBtnAvailable = true;
      isVisible = true;
      allChoicesBtn = false;
    });

    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == userChoice) {
        correctAnswersCount++;
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    if (quizBrain.isFinished()) {
      Timer(const Duration(seconds: 1), () {
        //show result dialog
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
        });
      });
    }
  }

  void startTimer() {
    timerInQuiz = TimerUtils();
    Stream<int> countdown = timerInQuiz!.countdown(from: 10);
    countdown.listen((int value) {
      setState(() {
        loadingValue = loadingValue! - 0.1;
        timerValue = timerValue! - 1;
      });
      if (timerValue == 0) {
        timerInQuiz!.cancelTimer();
        quizBrain.nextQuestion();
        restartTimer();
      }
    });
  }

  void cancelTimer() {
    timerInQuiz!.cancelTimer();
  }

  void restartTimer() {
    setState(() {
      loadingValue = 1;
      timerValue = 10;
    });
    startTimer();
  }

  void nextQuestion() {
    quizBrain.nextQuestion();
    restartTimer();
    setState(() {
      if(questionNumber != questionsCount) {
        allChoicesBtn = true;
        nextBtnAvailable = false;
        isVisible = false;
        questionNumber++;
      }
      else
        {
          score = (correctAnswersCount * 100 / questionsCount).round();
          showCustomAlert();
        }
    });
  }

  bool scoreStatus()=>score!>= 50?true:false;
  bool isAlertShown = false;

  void showCustomAlert() {
    if (isAlertShown) {
      return; // Don't show the alert if it has already been shown
    }
    QuickAlert.show(
      context: context,
      type: scoreStatus() ? QuickAlertType.success : QuickAlertType.error,
      text: scoreStatus() ? 'Transaction Completed Successfully!' : 'Transaction Failed',
      onConfirmBtnTap: () {
        Navigator.pushNamed(context, "/");
      },
    );
    isAlertShown = true;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: MYOutlineBtn(
                      icon: Icons.close,
                      iconColor: Colors.white,
                      bColor: Colors.white,
                      function: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: CircularProgressIndicator(
                          value: loadingValue,
                          color: Colors.white,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        timerValue.toString(),
                        style: const TextStyle(
                          fontFamily: 'Sf-Pro-Text',
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: const BorderSide(color: Colors.white)),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    onPressed: allChoicesBtn == true
                        ? () {
                            //The user picked true.
                            checkAnswer(true);
                          }
                        : null,
                    child: const Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: const ButtonStyle().copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: allChoicesBtn == true
                        ? () {
                            //The user picked false.
                            checkAnswer(false);
                          }
                        : null,
                    child: const Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                children: scoreKeeper,
              ),
              const SizedBox(
                height: 72,
              ),
              Visibility(
                visible: isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: nextBtnAvailable == true ? nextQuestion : null,
                      child: Text(
                        "Next",
                        style: nextBtnAvailable == true
                            ? const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )
                            : const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
