import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _onShow = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _onShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double containerWidth = widthScreen * 0.9;
    double containerHeight = heightScreen * 0.6;

    return Stack(children: [
      AnimatedPositioned(
          bottom: _onShow ? (heightScreen - containerHeight) / 2 : 150,
          //Center in horizontal
          left: (widthScreen - containerWidth) / 2,
          duration: const Duration(milliseconds: 500),
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: AnimatedOpacity(
                opacity: _onShow ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: myContainer(containerWidth, containerHeight)),
          ))
    ]);
  }

  Widget myContainer(double myWidth, double myHeight) {
    return Container(
      width: myWidth,
      height: myHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Blue_Archive/Image_Char_Arona2.png",
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: 20),
          Container(
            child: const Text(
              'This is my own Personal unofficial Application that store information about students in Kivotos of mobile game "Blue Archive" develop by Nexon Games and published by Yostar (Japan) and Nexon (Global) for iOS and Android.',
            ),
          ),
        ],
      ),
    );
  }
}
