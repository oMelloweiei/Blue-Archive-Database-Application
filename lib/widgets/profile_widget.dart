import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Student student;

  const Profile({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = student.name.replaceAll('(', '').replaceAll(')', '');
    final String onlyName =
        name.contains(' ') ? name.replaceAll(' ${student.outfit}', '') : name;

    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoContainer(onlyName),
          SizedBox(height: 10),
          _buildProfileContainer(onlyName),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String onlyName) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Image.asset(
              'assets/Blue_Archive/characters/profile_images/${student.name}.webp'
                  .replaceAll(' ', '_'),
              width: 75,
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.school == 'Tokiwadai' ||
                        student.school == 'ETC' ||
                        student.school == 'Sakugawa'
                    ? student.name
                    : '${student.familyName} $onlyName',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    student.school,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Text(
                      student.schoolyear,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                  width: 240,
                  child: Text(
                    student.club,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContainer(String onlyName) {
    final String age =
        student.age == "Age Unknown" || student.age == "Top Secret"
            ? student.age
            : "${student.age} years old";

    final String height =
        student.height == "Unmeasured" || student.height == "-"
            ? student.height
            : "${student.height} cm";

    final List<String> profileLore = [
      student.profileheader,
      student.profiledescipt,
      student.profiledialouge
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowDetail("Name : ", onlyName),
          _buildRowDetail("Family Name : ", student.familyName),
          _buildRowDetail("Birthday : ", student.birthday),
          _buildRowDetail("Age : ", age),
          _buildRowDetail("Height : ", height),
          _buildRowDetail("Hobby : ", student.hobby),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Divider(
              color: Colors.white,
              height: 2,
            ),
          ),
          _buildLoreContainer(profileLore),
        ],
      ),
    );
  }

  Widget _buildRowDetail(String topic, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            topic,
            textAlign: TextAlign.start,
          ),
          Expanded(
            child: Text(
              detail,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoreContainer(List<String> detail) {
    List<Widget> children = [];

    for (int i = 0; i < detail.length; i++) {
      if (detail[i] == "none") {
        continue;
      } else if (i == detail.length - 1 || detail[i + 1] == "none") {
        children.add(Text(
          detail[i],
          style: detail[i] == student.profiledialouge
              ? TextStyle(fontStyle: FontStyle.italic)
              : null,
        ));
      } else {
        children.add(Text(detail[i]));
        children.add(SizedBox(height: 20));
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: children,
      ),
    );
  }
}
