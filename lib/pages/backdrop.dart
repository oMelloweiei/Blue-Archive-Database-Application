import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/widgets/my_button.dart';
import 'package:my_project/widgets/att_widget.dart';
import 'package:my_project/widgets/skills_widget.dart';
import 'package:my_project/widgets/weapon_widget.dart';
import 'package:my_project/widgets/profile_widget.dart';

class Backdrop extends StatefulWidget {
  final Color atkColor;
  final Color defColor;
  final Student student;
  final String myBG;

  Backdrop(
      {Key? key,
      required this.student,
      required this.atkColor,
      required this.defColor,
      required this.myBG})
      : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> {
  final ScrollController _scrollController = ScrollController();
  late String imageSchoolPath;
  double _offset = 0;
  bool _onShow = false;

  Map<String, bool> buttonStates = {
    'Attributes': true,
    'Skills': false,
    'Weapon': false,
    'Profile': false,
  };

  void onPressed(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => value = false);
      buttonStates[buttonText] = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    imageSchoolPath =
        'assets/Blue_Archive/components/school_icons/${widget.student.school}.png';
    Future.delayed(Duration.zero, () {
      setState(() {
        _onShow = true;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _offset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = MediaQuery.of(context).size.height;
    final expandedWidth = MediaQuery.of(context).size.width;

    final imageName = widget.student.name.replaceAll(' ', '_');
    final imagePath =
        'assets/Blue_Archive/characters/artwork/${imageName}_00.webp';

    final displayName = widget.student.name.contains('(')
        ? widget.student.name.split(RegExp(r'\s(?=\()'))
        : [widget.student.name];

    final selectedWidget = _getSelectedWidget();

    return Stack(
      children: <Widget>[
        _buildBackdropBackground(),
        _buildCharacterImage(expandedHeight, expandedWidth, imagePath),
        _buildCharacterDetails(
          expandedHeight,
          expandedWidth,
          displayName,
          selectedWidget,
          imageSchoolPath,
        ),
      ],
    );
  }

  Widget _getSelectedWidget() {
    Widget selectedWidget;
    if (buttonStates['Attributes']!) {
      selectedWidget = Attributes(
        student: widget.student,
        imageSchoolPath: imageSchoolPath,
        atkColor: widget.atkColor,
        defColor: widget.defColor,
      );
    } else if (buttonStates['Skills']!) {
      selectedWidget = Skills(
        student: widget.student,
        atkColor: widget.atkColor,
        defColor: widget.defColor,
      );
    } else if (buttonStates['Weapon']!) {
      selectedWidget = Weapon(
        student: widget.student,
        atkColor: widget.atkColor,
      );
    } else {
      selectedWidget = Profile(student: widget.student);
    }
    return selectedWidget;
  }

  Widget _buildBackdropBackground() {
    return Positioned.fill(
      child: Container(
        child: Image.asset(
          widget.myBG,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCharacterImage(
    double expandedHeight,
    double expandedWidth,
    String imagePath,
  ) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: _onShow ? 10 : 30,
      left: 0,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        width: expandedWidth,
        alignment: Alignment.topCenter,
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _onShow ? 1 : 0,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: expandedHeight * 0.70,
            )),
      ),
    );
  }

  Widget _buildCharacterDetails(
    double expandedHeight,
    double expandedWidth,
    List<String> displayName,
    Widget selectedWidget,
    String imageSchoolPath,
  ) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(height: expandedHeight - 220),
            Container(
              margin: EdgeInsets.all(10),
              child: _buildCharacterDetailsCard(
                displayName,
                imageSchoolPath,
                selectedWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterDetailsCard(
    List<String> displayName,
    String imageSchoolPath,
    Widget selectedWidget,
  ) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromARGB(255, 23, 28, 32).withOpacity(0.9),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCharacterName(displayName),
                    imageSchoolPath !=
                            'assets/Blue_Archive/components/school_icons/Sakugawa.png'
                        ? Image.asset(imageSchoolPath, height: 75)
                        : Image.asset(
                            'assets/Blue_Archive/components/school_icons/ETC.png',
                            height: 75),
                  ],
                ),
                SizedBox(height: 20),
                OverflowBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: buttonStates.keys.map((buttonText) {
                    return CustomButton(
                      text: buttonText,
                      isSelected: buttonStates[buttonText]!,
                      onPressed: () {
                        onPressed(buttonText);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                selectedWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterName(List<String> displayName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            SizedBox(width: 5),
            Text(
              displayName[0],
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            if (displayName.length == 2)
              Text(
                displayName[1],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              )
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            _buildStarRating(widget.student.star),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(
                'assets/Blue_Archive/components/role_icons/${widget.student.role}.webp',
                height: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStarRating(int starCount) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.black.withOpacity(0.75),
      ),
      child: Row(
        children: List.generate(
          starCount,
          (index) => Image.asset(
            'assets/Blue_Archive/components/Star_Icon.webp',
            height: 20,
          ),
        ),
      ),
    );
  }
}
