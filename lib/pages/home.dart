import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/database/levels.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../widgets/my_level_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void moveToStartQuizPage(context, levelIndex) {
    Navigator.pushNamed(context, "/description", arguments: {
      "levelData": levels[levelIndex],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const SizedBox(
            height: 16,
          ),
          MYOutlineBtn(
            icon: Icons.favorite,
            iconColor: kBlueIcon,
            bColor: kGreyFont.withOpacity(0.5),
            function: () {
              print("11111");
            },
          ),
          MYOutlineBtn(
              icon: Icons.person,
              iconColor: kBlueIcon,
              bColor: kGreyFont.withOpacity(0.5),
              function: () {
                print("0595856486");
              }),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let\'s Play',
                style: TextStyle(
                  fontSize: 32,
                  color: kRedFont,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Be the First!',
                style: TextStyle(
                  fontSize: 18,
                  color: kGreyFont,
                  fontFamily: kFontFamily,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return MyLevelWidget(
                    function: () {
                      moveToStartQuizPage(context, index);
                    },
                    icon: levels[index].levelStatusIcon!,
                    title: levels[index].title,
                    subtitle: levels[index].levelText,
                    image: levels[index].image,
                    colors: levels[index].colors,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
