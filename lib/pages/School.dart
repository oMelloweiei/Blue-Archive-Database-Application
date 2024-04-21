import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/pages/Student_detail.dart';
import 'package:my_project/widgets/customBox.dart';

class School extends StatefulWidget {
  final List<Student> students;
  const School({super.key, required this.students});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  List<String> school = [];
  List<bool> showDetailList = [];
  List<String> img = [];
  bool _onShow = false;
  List<Student> filtedstudent = [];
  Color filted_Color = Color(0xFF000000);

  List<String> schoolList = [
    "Abydos High School",
    "Gehenna Academy",
    "Arius Branch School",
    "Millennium Science School",
    "Trinity General School",
    "Hyakkiyako Alliance Academy",
    "Shanhaijing Senior Secondary School",
    "Red Winter Federal Academy",
    "Valkyrie Police Academy",
    "SRT Special Academy"
  ];

  void closeStudentSchool() {
    setState(() {
      _onShow = false;
    });
  }

  @override
  void initState() {
    super.initState();
    showDetailList = List.filled(schoolList.length, false);
    // Initialize the school list by splitting each school name
    for (int i = 0; i < schoolList.length; i++) {
      String schoolName = schoolList[i].startsWith("Red Winter")
          ? "Red Winter"
          : schoolList[i].split(' ').first;
      school.add(schoolName);
      img.add("assets/Blue_Archive/components/school_icons/$schoolName.png");
    }
  }

  List<String> descriptionList = [
    "It used to be a thriving and prestigious school before desertification. Now, all that remains is a shadow of its former glory, with nothing more than an annex building and five students with an enormous debt to pay off.",
    "A school that runs along the concept of \"Freedom and Chaos.\" In contrast to its long rival, Trinity, this school is arguably the most chaotic out of all the schools.",
    "An exiled branch of Trinity, now living hidden underground filled with anger and hatred, waiting to one day seek revenge and pass judgement onto the school that brought all those suffering upon them.",
    "Despite its young age, it has carved its own path to become one of the largest schools in Kivotos. It values logic and technical skill over everything. If you're looking for technology, this is the place to go.",
    "A seemingly religious school that values order and etiquette. Unlike its long rival, Gehenna, this school is considerably the most orderly out of any school in Kivotos...at least, on the surface.",
    "An academy made up of a coalition of numerous different clubs, each with their own cultures and rules. The academy frequents in large-scale activities such as festivals.",
    "A school that focuses more on business and commerce, visibly prioritizing money over culture. This school is more known for its delicious restaurants and tourism.",
    "A snow-covered academy with an emphasis on communal effort...when it's not busy staging revolutions against its student council, that is. With its large territory, getting lost is pretty easy.",
    "A school responsible for maintaining order and peace all over Kivotos. Despite being the main law enforcement agency in Kivotos, they have low reaction times and a lack of important security protocols.",
    "A school of elites that was able to mobilize in any autonomous district through the General Student Council President's authority. However, with her disappearance, the school lost this capability and is effectively good as dead."
  ];

  List<Color> colorList = [
    const Color(0xFF06BBFA),
    const Color(0xFFE34A45),
    const Color(0xFFDBDAD8),
    const Color(0xFF4F86F7),
    const Color(0xFFFBB35A),
    const Color(0xFFE05289),
    const Color(0xFF03C03C),
    const Color(0xFFB23B59),
    const Color(0xFFA1A9E1),
    const Color(0xFF90ABC9),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.background,
        ),
        body: Stack(children: [
          Container(
            color: theme.colorScheme.background,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(10),
              itemCount: schoolList.length,
              itemBuilder: (BuildContext context, int index) {
                return myList(index, theme);
              },
            ),
          ),
          if (_onShow)
            Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.6),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _onShow = false;
                        });
                      },
                    ),
                  ),
                  studentSchool(
                    filtedstudent: filtedstudent,
                    filtedColor: filted_Color,
                    onClose: closeStudentSchool,
                  )
                ],
              ),
            )
        ]));
  }

  Widget myList(int index, ThemeData theme) {
    return Container(
        child: GestureDetector(
            onTap: () {
              setState(() {
                showDetailList[index] = !showDetailList[index];
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: colorList[index],
              ),
              child: Column(children: [
                Center(
                    child: Text('${schoolList[index]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: theme.textTheme.bodyLarge!.fontWeight,
                        ))),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: showDetailList[index] ? 240 : 0,
                    padding: EdgeInsets.all(7),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 10),
                      Row(children: [
                        Image.asset(
                          img[index],
                          fit: BoxFit.cover,
                          width: 100,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(descriptionList[index],
                                style: TextStyle(color: Colors.black))),
                      ]),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _onShow = true;
                              filtedstudent = widget.students
                                  .where((student) =>
                                      student.school == school[index])
                                  .toList();
                              filted_Color = colorList[index];
                            });
                          },
                          child: Text('See Detail'))
                    ]))),
              ]),
            )));
  }
}

class studentSchool extends StatefulWidget {
  final List<Student> filtedstudent;
  final Color filtedColor;
  final VoidCallback onClose;

  const studentSchool(
      {super.key,
      required this.filtedstudent,
      required this.filtedColor,
      required this.onClose});

  @override
  State<studentSchool> createState() => _studentSchoolState();
}

class _studentSchoolState extends State<studentSchool> {
  bool _onShow = false;

  List<String> clubs = [];

  @override
  void initState() {
    super.initState();
    for (Student student in widget.filtedstudent) {
      if (clubs.contains(student.club)) {
        continue;
      } else {
        clubs.add(student.club);
      }
    }
    Future.delayed(Duration.zero, () {
      setState(() {
        _onShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      left: (MediaQuery.of(context).size.width - 350) / 2,
      top: _onShow ? (MediaQuery.of(context).size.height - 600) / 2 : 180,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.filtedColor,
          image: DecorationImage(
              opacity: 0.4,
              image: AssetImage(
                  'assets/Blue_Archive/background/${widget.filtedstudent[1].school}_Intro.webp'),
              fit: BoxFit.cover),
        ),
        width: 350,
        height: 500,
        child: Column(children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(2),
              child: IconButton(
                  onPressed: widget.onClose,
                  icon: Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.black,
                  ))),
          Expanded(
              child: ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              // Retrieve students with the current club
              List<Student> studentsWithClub = widget.filtedstudent
                  .where((student) => student.club == clubs[index])
                  .toList();
              return gridStudentClub(index, studentsWithClub);
            },
          ))
        ]),
      ),
    );
  }

  Widget gridStudentClub(int index, List<Student> studentsWithClub) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 40,
            child: Text(
              style: TextStyle(color: Colors.black, fontSize: 18),
              clubs[index],
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Adjust the number of columns as needed
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
            ),
            itemCount: studentsWithClub.length,
            itemBuilder: (context, index) {
              // Display details of each student with the current club
              return AnimatedOpacity(
                  opacity: _onShow ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: GestureDetector(
                      onTap: () {
                        // Retrieve the student object corresponding to the tapped item
                        Student tappedStudent = studentsWithClub[index];
                        // Print the details of the tapped student
                        // tappedStudent.printInfo();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetailScreen(
                              student: tappedStudent,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 7),
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: ParallelogramBorderPainter(
                            borderWidth: 5.0, // Adjust border width as needed
                            borderColor:
                                Colors.white, // Adjust border color as needed
                          ),
                          child: ClipPath(
                            clipper: myParallelogram(
                                cornerRadius:
                                    20.0), // Adjust corner radius as needed
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/Blue_Archive/characters/profile_images/${(studentsWithClub[index].name).replaceAll(' ', '_')}.webp",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )));
            },
          ),
        ],
      ),
    );
  }
}
