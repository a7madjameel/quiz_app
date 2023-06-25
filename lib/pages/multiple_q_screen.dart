import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../constants.dart';
import '../modules/multipe_choice/quizBrainMultiple.dart';
import '../modules/timer_utils.dart';
class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  TimerUtils? timerInQuiz;
  double? loadingValue=1;
  int? timerValue=10;
  QuizBrainMulti quizBrainMulti = QuizBrainMulti();
  int? userChoice;
  bool? isCorrect;
  int questionsCount = 0;
  int correctAnswersCount = 0;
  int? score ;
  int questionNumber = 1;
  bool nextBtnAvailable = false;
  bool isVisible = false;
  bool isOptionSelected = false;
  void checkAnswer() {
    int correctAnswer = quizBrainMulti.getQuestionAnswer();
    cancelTimer();
    setState(() {
      isOptionSelected=!isOptionSelected;

      if (correctAnswer == userChoice) {
        isCorrect = true;
        correctAnswersCount++;
      } else {
        isCorrect = false;
      }
    });

    if (quizBrainMulti.isFinished()) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          quizBrainMulti.reset();
        });
      });
    }
  }
  void nextQuestion() {
    quizBrainMulti.nextQuestion();
    restartTimer();
    setState(() {
      isOptionSelected=!isOptionSelected;
      if (questionNumber != questionsCount) {
        userChoice =null;
        //allChoicesBtn = true;
        nextBtnAvailable = false;
        isVisible = false;
        questionNumber++;
      } else {
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
  void initState() {
    questionsCount = quizBrainMulti.getQuestionCount();
    super.initState();
    startTimer();
  }
  void startTimer() {
    timerInQuiz = TimerUtils();
    Stream<int> countdown = timerInQuiz!.countdown(from: 10);
    countdown.listen((int value) {
      setState(() {
        loadingValue = value / 10;
        timerValue = value;
      });
      if (timerValue == 0) {
        timerInQuiz!.cancelTimer();
        nextQuestion();
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
  @override
  void dispose() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              Text(
                'question $questionNumber of $questionsCount',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                quizBrainMulti.getQuestionText(),
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizBrainMulti.getOptions().length,
                itemBuilder: (context, index) {
                  String choice = quizBrainMulti.getOptions()[index];
                  bool isSelected = userChoice == index;
                  bool isAnswerCorrect = isCorrect != null && isCorrect! && isSelected;
                  bool isAnswerWrong = isCorrect != null && !isCorrect! && isSelected;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: isOptionSelected ? null : () { // Disable button if an option has been selected
                        setState(() {
                          userChoice = index;
                          checkAnswer();
                          nextBtnAvailable = true;
                          isVisible = true;
                          isOptionSelected = true; // Update the flag to indicate that an option has been selected
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: isAnswerCorrect ? Colors.green : isAnswerWrong ? Colors.red : Colors.white,
                        backgroundColor: isAnswerCorrect ? Colors.green : isAnswerWrong ? Colors.red : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 24),
                          Expanded(
                            child: Center(
                              child: Text(
                                choice,
                                style: const TextStyle(
                                  color: kL2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              isAnswerCorrect ? Icons.check_rounded : Icons.close_rounded,
                              color: kL2,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: nextBtnAvailable ? nextQuestion : null,
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: nextBtnAvailable ? Colors.white : Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
