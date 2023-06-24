import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../constants.dart';
import '../modules/timer_utils.dart';

class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> {
  TimerUtils? timerInQuiz;
  double? loadingValue = 1;
  int? timerValue = 10;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
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
        //nextQuestion();
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
    // TODO: implement dispose
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var questionNumber = 5;
    var questionsCount = 10;
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
                        // Navigator.pop(context);
                        // Navigator.pop(context);

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
              const Text(
                'In Which City of Germany Is the Largest Port?',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 24),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Bremen',
                            style: TextStyle(
                              color: kL2,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: kL2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Bremen',
                            style: TextStyle(
                                color: kL2,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: kL2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kG1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Gaza',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
