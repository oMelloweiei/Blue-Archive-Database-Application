import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Student>> loadJsonFile() async {
  final jsonString = await rootBundle
      .loadString('assets/Blue_Archive/merged_data_2_test.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);

  return jsonList.map((characterJson) {
    return Student.fromJson(characterJson);
  }).toList();
}

class Student {
  final String id;
  final String exId;
  final String nmId;
  final String name;
  final String rarity;
  final String profileId;
  final String outfit;
  final String school;
  final String combat;
  final String atkType;
  final String defType;
  final String position;
  final int star;
  final String city;
  final String outdoor;
  final String indoor;
  final String role;
  final String familyName;
  final String height;
  final String age;
  final String hobby;
  final String club;
  final String weaponName;
  final String weaponType;
  final String weaponDescription;
  final String exSkillName;
  final String exSkillDetail;
  final String exSkillIcon;
  final String exSkillCost;
  final String normalSkillName;
  final String normalSkillDetail;
  final String normalSkillIcon;
  final String normalSkillCost;
  final String passiveSkillName;
  final String passiveSkillDetail;
  final String passiveSkillIcon;
  final String passiveSkillCost;
  final String subSkillName;
  final String subSkillDetail;
  final String subSkillIcon;
  final String subSkillCost;
  final String exFirstAddonType;
  final String exFirstAddonName;
  final String exFirstAddonDetail;
  final String exFirstAddonIcon;
  final String exFirstAddonCost;
  final String exSecondAddonType;
  final String exSecondAddonName;
  final String exSecondAddonDetail;
  final String exSecondAddonIcon;
  final String exThirdAddonType;
  final String exThirdAddonName;
  final String exThirdAddonDetail;
  final String exThirdAddonIcon;
  final String normalFirstAddonType;
  final String normalFirstAddonName;
  final String normalFirstAddonDetail;
  final String normalFirstAddonIcon;
  final String weaponSkillName;
  final String weaponSkillDetail;
  final String weaponSkillIcon;
  final String weaponSkillCost;
  final String firstslot;
  final String secondslot;
  final String thirdslot;
  final String birthday;
  final String schoolyear;
  final String profileheader;
  final String profiledescipt;
  final String profiledialouge;

  Student({
    required this.id,
    required this.exId,
    required this.nmId,
    required this.name,
    required this.rarity,
    required this.profileId,
    required this.outfit,
    required this.school,
    required this.combat,
    required this.atkType,
    required this.defType,
    required this.position,
    required this.star,
    required this.city,
    required this.outdoor,
    required this.indoor,
    required this.role,
    required this.familyName,
    required this.height,
    required this.age,
    required this.hobby,
    required this.club,
    required this.weaponName,
    required this.weaponType,
    required this.weaponDescription,
    required this.exSkillName,
    required this.exSkillDetail,
    required this.exSkillIcon,
    required this.exSkillCost,
    required this.normalSkillName,
    required this.normalSkillDetail,
    required this.normalSkillIcon,
    required this.normalSkillCost,
    required this.passiveSkillName,
    required this.passiveSkillDetail,
    required this.passiveSkillIcon,
    required this.passiveSkillCost,
    required this.subSkillName,
    required this.subSkillDetail,
    required this.subSkillIcon,
    required this.subSkillCost,
    required this.exFirstAddonType,
    required this.exFirstAddonName,
    required this.exFirstAddonDetail,
    required this.exFirstAddonIcon,
    required this.exFirstAddonCost,
    required this.exSecondAddonType,
    required this.exSecondAddonName,
    required this.exSecondAddonDetail,
    required this.exSecondAddonIcon,
    required this.exThirdAddonType,
    required this.exThirdAddonName,
    required this.exThirdAddonDetail,
    required this.exThirdAddonIcon,
    required this.normalFirstAddonType,
    required this.normalFirstAddonName,
    required this.normalFirstAddonDetail,
    required this.normalFirstAddonIcon,
    required this.weaponSkillName,
    required this.weaponSkillDetail,
    required this.weaponSkillIcon,
    required this.weaponSkillCost,
    required this.firstslot,
    required this.secondslot,
    required this.thirdslot,
    required this.birthday,
    required this.schoolyear,
    required this.profileheader,
    required this.profiledescipt,
    required this.profiledialouge,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        exId: json['ex_id'],
        nmId: json['nm_id'],
        name: json['name'],
        rarity: json['rarity'],
        profileId: json['profile_id'],
        outfit: json['outfit'],
        school: json['school'],
        combat: json['combat_class'],
        atkType: json['atk_type'],
        defType: json['def_type'],
        position: json['position'],
        star: json['star'],
        city: json['city'],
        outdoor: json['outdoor'],
        indoor: json['indoor'],
        role: json['role'],
        familyName: json['Family Name'],
        height: json['Height'],
        age: json['Age'],
        hobby: json['Hobby'],
        club: json['Club'],
        weaponName: json['Weapon Name'],
        weaponType: json['Weapon Type'],
        weaponDescription: json['Weapon Description'],
        exSkillName: json['Ex Skill Name'],
        exSkillDetail: json['Ex Skill Detail'],
        exSkillIcon: json['Ex Skill Icon'],
        exSkillCost: json['Ex Skill Cost'],
        normalSkillName: json['Normal Skill Name'],
        normalSkillDetail: json['Normal Skill Detail'],
        normalSkillIcon: json['Normal Skill Icon'],
        normalSkillCost: json['Normal Skill Cost'] ?? '',
        passiveSkillName: json['Passive Skill Name'],
        passiveSkillDetail: json['Passive Skill Detail'],
        passiveSkillIcon: json['Passive Skill Icon'],
        passiveSkillCost: json['Passive Skill Cost'] ?? '',
        subSkillName: json['Sub Skill Name'],
        subSkillDetail: json['Sub Skill Detail'],
        subSkillIcon: json['Sub Skill Icon'],
        subSkillCost: json['Sub Skill Cost'] ?? '',
        exFirstAddonType: json['Ex First Add-on Type'] ?? '',
        exFirstAddonName: json['Ex First Add-on Name'] ?? '',
        exFirstAddonDetail: json['Ex First Add-on Detail'] ?? '',
        exFirstAddonIcon: json['Ex First Add-on Icon'] ?? '',
        exFirstAddonCost: json['Ex First Add-on Cost'] ?? '',
        exSecondAddonType: json['Ex Second Add-on Type'] ?? '',
        exSecondAddonName: json['Ex Second Add-on Name'] ?? '',
        exSecondAddonDetail: json['Ex Second Add-on Detail'] ?? '',
        exSecondAddonIcon: json['Ex Second Add-on Icon'] ?? '',
        exThirdAddonType: json['Ex Third Add-on Type'] ?? '',
        exThirdAddonName: json['Ex Third Add-on Name'] ?? '',
        exThirdAddonDetail: json['Ex Third Add-on Detail'] ?? '',
        exThirdAddonIcon: json['Ex Third Add-on Icon'] ?? '',
        normalFirstAddonType: json['Normal First Add-on Type'] ?? '',
        normalFirstAddonName: json['Normal First Add-on Name'] ?? '',
        normalFirstAddonDetail: json['Normal First Add-on Detail'] ?? '',
        normalFirstAddonIcon: json['Normal First Add-on Icon'] ?? '',
        weaponSkillName: json['Weapon Skill Name'],
        weaponSkillDetail: json['Weapon Skill Detail'],
        weaponSkillIcon: json['Weapon Skill Icon'],
        weaponSkillCost: json['Weapon Skill Cost'] ?? '',
        firstslot: json['Equipment First Slot'],
        secondslot: json['Equipment Second Slot'],
        thirdslot: json['Equipment Third Slot'],
        birthday: json['Birthday'],
        schoolyear: json['School Year'],
        profileheader: json['Profile Header'] ?? '',
        profiledescipt: json['Profile Script'] ?? '',
        profiledialouge: json['Profile Dialouge'] ?? '');
  }
}
