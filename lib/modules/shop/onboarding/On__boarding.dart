
import 'package:flutter/material.dart';

import 'package:on_boarding/shared/componnents0/components.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';
import 'package:on_boarding/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../login/login.dart';


class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

    var boardController = PageController();
    List<BoardingModel> boarding = [
      BoardingModel(
          image: 'image/images5.png',
          title: 'Onboard 1 title',
          body: 'On board 1 body'),
      BoardingModel(
          image: 'image/images7.png',
          title: 'Onboard 2 title',
          body: 'On board 2 body'),
      BoardingModel(
          image: 'image/images8.png',
          title: 'Onboard 3 title',
          body: 'On board 3 body'),
    ];
    bool islast = false;
    void submit() {
      CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then((value)
      {
        if (value) {
          navigateAndFinish(
            context,
            Shoplogin(),
          );
        }
      });
    }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: (){ submit();

        }, child: Text('skip'))],

      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultcolor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
      if(islast){submit();}
                    else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${model.image}'),
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
}

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}
