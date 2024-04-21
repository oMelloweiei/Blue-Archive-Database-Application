import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';

class Weapon extends StatelessWidget {
  final Student student;
  final Color atkColor;

  const Weapon({Key? key, required this.student, required this.atkColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          _buildWeaponContainer(),
          Divider(
            color: Colors.grey.shade500,
            height: 2,
          ),
          _buildWeaponSkillContainer(),
        ],
      ),
    );
  }

  Widget _buildWeaponContainer() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  student.weaponName,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/Blue_Archive/components/firearm_icons/Common_Icon_CharacterWeapon_off.png',
                    height: 25,
                  ),
                  Text(student.weaponType),
                ],
              )
            ],
          ),
          SizedBox(height: 2),
          Divider(
            color: Colors.white,
            height: 2,
          ),
          _buildWeaponinfo(),
        ],
      ),
    );
  }

  Widget _buildWeaponinfo() {
    final String name = student.name.replaceAll('(', '').replaceAll(')', '');

    final String onlyName =
        name.contains(' ') ? name.replaceAll(' ${student.outfit}', '') : name;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Image.asset(
              'assets/Blue_Archive/characters/weapons/$onlyName.webp',
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              student.weaponDescription,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponSkillContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: Column(
        children: [
          _buildWeaponTopic(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              student.weaponSkillDetail,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponTopic() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(student.weaponSkillIcon, atkColor),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  student.weaponSkillName,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Enhanced Skill+',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String img, Color color) {
    return Stack(
      children: [
        ClipOval(
          child: Container(
            color: color,
            child: Image.asset(
              'assets/Blue_Archive/components/skill_icons/$img.webp',
              width: 60,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ClipOval(
            child: Container(
              color: color,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
