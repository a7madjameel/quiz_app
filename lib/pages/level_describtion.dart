import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/modules/level.dart';

import '../widgets/my_outline_btn.dart';

class LevelDescription extends StatelessWidget {
  const LevelDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modelRoute =
        ModalRoute.of(context)?.settings.arguments as Map<String, Level>;
    final args = modelRoute["levelData"];

    void moveToQuestionScreen(context) {
      if (args!.levelText == "Level 1") {
        Navigator.of(context).pushReplacementNamed("/true_false_question");
      } else {
        Navigator.of(context).pushReplacementNamed("/multi_question");
      }
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: args!.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MYOutlineBtn(
                icon: Icons.close,
                function: () {
                  Navigator.pop(context);
                },
                bColor: Colors.white60,
                iconColor: Colors.white,
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    args.image,
                  ),
                ),
              ),
              Text(
                args.levelText,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 18,
                  fontFamily: "sf-pro-Text",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Continuing",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "sf-pro-Text",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                args.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "sf-pro-Text",
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  moveToQuestionScreen(context);
                },
                child: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Play",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
