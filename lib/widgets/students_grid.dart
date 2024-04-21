import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/pages/Student_detail.dart';

class StudentGrid extends StatelessWidget {
  final List<Student> students;
  final List<String> filtedRole;
  final List<String> filtedRarity;
  final List<String> filtedCombat_Class;
  final List<String> filtedstar;
  final List<String> filtedatkType;
  final List<String> filteddefType;
  final List<String> filtedposition;
  final List<String> filtedschool;
  final List<String> filtedweaponType;
  final List<String> filtedoutfits;
  bool reverse_sort;
  String searchStudent;

  StudentGrid({
    Key? key,
    required this.students,
    required this.filtedRole,
    required this.filtedRarity,
    required this.filtedCombat_Class,
    required this.filtedstar,
    required this.filtedatkType,
    required this.filteddefType,
    required this.filtedposition,
    required this.filtedschool,
    required this.filtedweaponType,
    required this.filtedoutfits,
    required this.reverse_sort,
    required this.searchStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //convert str list to int list
    List<int> filted_star_int =
        filtedstar.map((str) => int.parse(str)).toList();

    if (reverse_sort)
      students.sort((b, a) => a.name.compareTo(b.name));
    else
      students.sort((a, b) => a.name.compareTo(b.name));

    List<Student> filteredStudents = students.where((student) {
      return (filtedRole.isEmpty || filtedRole.contains(student.role)) &&
          (filtedRarity.isEmpty || filtedRarity.contains(student.rarity)) &&
          (filtedCombat_Class.isEmpty ||
              filtedCombat_Class.contains(student.combat)) &&
          (filted_star_int.isEmpty || filted_star_int.contains(student.star)) &&
          (filtedatkType.isEmpty || filtedatkType.contains(student.atkType)) &&
          (filteddefType.isEmpty || filteddefType.contains(student.defType)) &&
          (filtedposition.isEmpty ||
              filtedposition.contains(student.position)) &&
          (filtedschool.isEmpty || filtedschool.contains(student.school)) &&
          (filtedweaponType.isEmpty ||
              filtedweaponType.contains(student.weaponType)) &&
          (filtedoutfits.isEmpty || filtedoutfits.contains(student.outfit)) &&
          (searchStudent.isEmpty || student.name.contains(searchStudent));
    }).toList();

    return Container(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width ~/ 95).toInt(),
            childAspectRatio: 0.89,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredStudents.length,
          itemBuilder: (context, index) {
            final imageName = filteredStudents[index].name.replaceAll(' ', '_');
            final imagePath =
                'assets/Blue_Archive/characters/profile_images/$imageName.webp';
            //This for handle name and slice string
            // String name = students[index].name;
            // int openParenIndex = name.indexOf('(');
            // int closeParenIndex = name.indexOf(')');
            // String firstPart = name;
            // String secondPart = '';
            // if (openParenIndex != -1 &&
            //     closeParenIndex != -1 &&
            //     openParenIndex < closeParenIndex) {
            //   firstPart = name.substring(0, openParenIndex).trim();
            //   secondPart = name.substring(openParenIndex).trim();
            // }
            return GestureDetector(
              onTap: () {
                // Retrieve the student object corresponding to the tapped item
                Student tappedStudent = filteredStudents[index];
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
              child: GridTile(
                child: Card(
                  color: Colors.grey,
                  // height: 120,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(imagePath, fit: BoxFit.cover),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          height: 27, // Define a fixed height
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.7),
                          child: Text(
                            filteredStudents[index].name,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            //handle long text
                            style: !filteredStudents[index].name.contains(' ')
                                ? TextStyle(fontSize: 12)
                                : TextStyle(fontSize: 10, height: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
