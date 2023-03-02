import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = (currentPage + 1) % 5;
      controller.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    // controller에서 dispose해주지 않으면 메모리 leak 날 수도 있음
    controller.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
