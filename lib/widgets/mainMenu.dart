import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/pages/School.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/memorial_page.dart';

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _onShow = false;

  late Future<List<Student>> _studentsFuture;
  late List<Student> _students = [];

  // Use descriptive names and prefix private variables with underscore
  List<String> _myContent = ["Students", "Schools", "Memorial_Lobby"];
  List<String> _myContentLogo = [
    "MP_Student.webp",
    "MP_School.webp",
    "MP_BA.webp"
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _onShow = true;
      });
    });
    _studentsFuture = loadStudents();
    _studentsFuture
        .then((value) => _students = value); // Assign loaded students
  }

  Future<List<Student>> loadStudents() async {
    try {
      // Load students data asynchronously
      return await loadJsonFile();
    } catch (e) {
      // Handle error
      print('Error loading students: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double containerWidth = widthScreen * 0.9;
    double containerHeight = heightScreen * 0.8;

    return Stack(
      children: [
        AnimatedPositioned(
          top: _onShow ? (heightScreen - containerHeight) / 2 : 20,
          left: (widthScreen - containerWidth) / 2,
          duration: const Duration(milliseconds: 500),
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: _onShow ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: _buildContainer(containerWidth, containerHeight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(double myWidth, double myHeight) {
    return Container(
      width: myWidth,
      height: myHeight,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            "assets/Blue_Archive/Blue_Archive_logo_JP.png",
            fit: BoxFit.cover,
            width: 200,
          ),
          _students.isEmpty ? CircularProgressIndicator() : _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _myContent.length,
        itemBuilder: (context, index) {
          String imagePath =
              "assets/Blue_Archive/contents/${_myContentLogo[index]}";
          return GestureDetector(
            onTap: () {
              if (index == 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Memorial_Lobby(
                      students: _students,
                    ),
                  ),
                );
              else if (index == 0)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      students: _students,
                    ),
                  ),
                );
              else if (index == 1)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => School(
                      students: _students,
                    ),
                  ),
                );
            },
            child: GridTile(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      child: Text(
                        _myContent[index],
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
