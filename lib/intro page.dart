import 'package:flutter/material.dart';
import 'package:nba_app/homepage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_screens/screen1.dart';
import 'onboarding_screens/screen2.dart';
import 'onboarding_screens/screen3.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // controller to keep track of which page we're on
  final PageController _controller = PageController();

  // keep track of if we are on the last page or not
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //Page View slides
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            Screen1(),
            Screen2(),
            Screen3(),
          ],
        ),
        // Dot indicators
        Container(
          alignment: Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // skip button here
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: const Text('Skip'),
              ),
              SmoothPageIndicator(
                controller: _controller,
                effect: const WormEffect(
                    dotColor: Colors.white,
                    activeDotColor: Colors.cyanAccent,
                    dotHeight: 10,
                    dotWidth: 10),
                count: 3,
              ),
              // next or done button here
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: const Text('Done'),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Next'),
                    ),
            ],
          ),
        )
      ],
    ));
  }
}
