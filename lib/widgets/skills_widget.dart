import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';

class Skills extends StatefulWidget {
  final Student student;
  final Color atkColor;
  final Color defColor;
  const Skills(
      {Key? key,
      required this.student,
      required this.atkColor,
      required this.defColor})
      : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  late List<String> exSkill = [];
  late List<String> normalSkill = [];
  late List<String> passiveSkill = [];
  late List<String> subSkill = [];
  List<String>? exAddon1;
  List<String>? exAddon2;
  List<String>? exAddon3;
  List<String>? nAddon;

  @override
  void initState() {
    super.initState();
    skill();
  }

  void skill() {
    exSkill = getSkill(
      widget.student.exSkillName,
      widget.student.exSkillCost,
      widget.student.exSkillDetail,
      widget.student.exSkillIcon,
    );
    normalSkill = getSkill(
      widget.student.normalSkillName,
      widget.student.normalSkillCost,
      widget.student.normalSkillDetail,
      widget.student.normalSkillIcon,
    );
    passiveSkill = getSkill(
      widget.student.passiveSkillName,
      widget.student.passiveSkillCost,
      widget.student.passiveSkillDetail,
      widget.student.passiveSkillIcon,
    );
    subSkill = getSkill(
      widget.student.subSkillName,
      widget.student.subSkillCost,
      widget.student.subSkillDetail,
      widget.student.subSkillIcon,
    );

    if (widget.student.exId != "0") {
      exAddon1 = getAddonSkill(
        widget.student.exFirstAddonName,
        widget.student.exFirstAddonType,
        widget.student.exFirstAddonDetail,
        widget.student.exFirstAddonIcon,
        cost: widget.student.exFirstAddonCost,
      );
      if (widget.student.exSecondAddonName != "none")
        exAddon2 = getAddonSkill(
          widget.student.exSecondAddonName,
          widget.student.exSecondAddonType,
          widget.student.exSecondAddonDetail,
          widget.student.exSecondAddonIcon,
        );
      if (widget.student.exThirdAddonName != "none")
        exAddon3 = getAddonSkill(
          widget.student.exThirdAddonName,
          widget.student.exThirdAddonType,
          widget.student.exThirdAddonDetail,
          widget.student.exThirdAddonIcon,
        );
    }

    if (widget.student.nmId != "0") {
      nAddon = getAddonSkill(
        widget.student.normalFirstAddonName,
        widget.student.normalFirstAddonType,
        widget.student.normalFirstAddonDetail,
        widget.student.normalFirstAddonIcon,
      );
    }
  }

  List<String> getSkill(
    String name,
    String cost,
    String detail,
    String image,
  ) {
    return [name, cost, detail, image];
  }

  List<String> getAddonSkill(
    String name,
    String type,
    String detail,
    String image, {
    String cost = "0",
  }) {
    return [name, type, detail, image, cost];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          SkillContainer(exSkill, "Ex Skill"),
          if (exAddon1?.isNotEmpty ?? false || exAddon1 == "none")
            SkillContainer(exAddon1!, "Ex Add-On Skill"),
          if (exAddon2?.isNotEmpty ?? false || exAddon2 == "none")
            SkillContainer(exAddon2!, "Ex Add-On Skill"),
          if (exAddon3?.isNotEmpty ?? false || exAddon3 == "none")
            SkillContainer(exAddon3!, "Ex Add-On Skill"),
          SkillContainer(
            normalSkill,
            "Normal Skill",
          ),
          if (nAddon?.isNotEmpty ?? false || exAddon1 == "none")
            SkillContainer(nAddon!, "Normal Add-On Skill"),
          SkillContainer(passiveSkill, "Passive Skill"),
          SkillContainer(subSkill, "Sub Skill"),
        ],
      ),
    );
  }

  Widget SkillContainer(List<String> skill, String type) {
    return Container(
      padding: type == "Ex Skill" ||
              type == "Normal Skill" ||
              type == "Passive Skill" ||
              type == "Sub Skill"
          ? EdgeInsets.all(15)
          : EdgeInsets.fromLTRB(40, 15, 15, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Column(children: [
        if (type != "Ex Skill")
          Column(
            children: [
              Divider(height: 2, color: Colors.grey),
              SizedBox(height: 10),
            ],
          ),
        SkillBox(skill[0], skill[1], skill[2], skill[3], type),
      ]),
    );
  }

  Widget SkillBox(
      String Name, String Cost, String Detail, String Img, String type) {
    final String img = "assets/Blue_Archive/components/skill_icons/${Img}.webp";

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: widget.atkColor,
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: (type == "Ex Skill" ||
                            type == "Normal Skill" ||
                            type == "Passive Skill" ||
                            type == "Sub Skill")
                        ? 220
                        : 200,
                    child: Text(
                      Name,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    type == "Ex Skill" ? '$type ・ Cost: $Cost' : type,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          Detail,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
