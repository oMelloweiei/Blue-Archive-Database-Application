import 'package:flutter/material.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/pages/backdrop.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  StudentDetailScreen({Key? key, required this.student}) : super(key: key);

  Color getAtkColor(String atkType) {
    switch (atkType) {
      case "Explosive":
        return const Color(0xFFA70B1A);
      case "Penetration":
        return const Color(0xFFB26D1E);
      case "Mystic":
        return const Color(0xFF226F9C);
      case "Sonic":
        return const Color(0xFF9431A5);
      default:
        return Colors.black;
    }
  }

  Color getDefColor(String defType) {
    switch (defType) {
      case "Light Armor":
        return const Color(0xFFA70B1A);
      case "Heavy Armor":
        return const Color(0xFFB26D1E);
      case "Special Armor":
        return const Color(0xFF226F9C);
      case "Elastic Armor":
        return const Color(0xFF9431A5);
      default:
        return Colors.black;
    }
  }

  String getSwimYear(String school, String name, String outfit) {
    if (school == 'Hyakkiyako' && name != 'Wakamo (Swimsuit)') {
      return "BG_${outfit}03_Collection";
    } else if (school == 'Trinity' || school == 'Gehenna') {
      if (name != 'Ui (Swimsuit)' ||
          name != 'Hinata (Swimsuit)' ||
          name != 'Koharu (Swimsuit)') {
        return "BG_${outfit}_Collection";
      } else {
        return "BG_WaterFall_Collection";
      }
    } else if (school == 'Abydos' || name == 'Wakamo (Swimsuit)') {
      return "BG_${outfit}02_Collection";
    } else if (school == 'SRT') {
      return "BG_FishingVillage2_Collection";
    } else if (name == 'Eimi (Swimsuit)') {
      return "BG_FrozenSea_Collection";
    } else {
      return "BG_View_Kivotos_Collection";
    }
  }

  String getNewYear(String name, String outfit) {
    switch (name) {
      case 'Aru (New Year)' ||
            'Mutsuki (New Year)' ||
            'Haruka (New Year)' ||
            'Kayoko (New Year)' ||
            'Serika (New Year)':
        return "BG_Newyear_Collection";
      case 'Akari (New Year)' ||
            'Fuuka (New Year)' ||
            'Junko (New Year)' ||
            'Haruna (New Year)':
        return "BG_NewYearFestival2";
      default:
        return "BG_View_Kivotos_Collection";
    }
  }

  String getDress(String name, String club) {
    switch (club) {
      case 'Problem Solver 68':
        return "BG_OperaHouse_Collection";
      case 'Prefect Team':
        return "BG_GehennaPartyRoom_Collection";
      default:
        return "BG_View_Kivotos_Collection";
    }
  }

  String getEventbg(String event, String school) {
    switch (event) {
      case 'Bunny Girl':
        return "BG_BunnyGirl_Collection";
      case 'New Year':
        return getNewYear(student.name, event);
      case 'Swimsuit':
        return getSwimYear(school, student.name, event);
      case 'Maid':
        return "BG_OldHouseOutside_Collection";
      case 'Sportswear' || 'Cheerleader':
        return "BG_Cheerleading_Collection";
      case 'Christmas':
        return "BG_Holiday_Collection";
      case 'Guide':
        return "BG_HyakkiyakoTreeSquare_Collection";
      case 'Camping':
        return "BG_CampSite_Collection";
      case 'Dress':
        return getDress(student.name, student.club);
      case 'Riding':
        return "BG_Ridingsuit_Collection";
      case 'Hot Spring':
        return "BG_Onsen_Collection";
      case 'Casual':
        return "BG_Saya_casual_Collection";
      case 'Kid':
        return "BG_CH0066_Collection";
      default:
        return "BG_View_Kivotos_Collection";
    }
  }

  String getschoolbg(String school) {
    switch (school) {
      case 'Red Winter':
        return "BG_Redwinter_Collection";
      case 'ETC':
        return "BG_CH9999_Collection";
      case 'Sakugawa' || 'Tokiwadai':
        return "BG_BigPlaza_Collection";
      default:
        return "BG_${school}_Collection";
    }
  }

  String getbackground(String outfit, String school) {
    return outfit == "Uniform"
        ? getschoolbg(school)
        : getEventbg(outfit, school);
  }

  @override
  Widget build(BuildContext context) {
    final String background = getbackground(student.outfit, student.school);
    final String mybackground =
        "assets/Blue_Archive/background/$background.webp";
    final ThemeData theme = Theme.of(context);
    final atkColor = getAtkColor(student.atkType);
    final defColor = getDefColor(student.defType);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Detail',
          style: theme.textTheme.headline6,
        ),
        backgroundColor: theme.colorScheme.background.withOpacity(0.9),
      ),
      body: Backdrop(
        student: student,
        atkColor: atkColor,
        defColor: defColor,
        myBG: mybackground,
      ),
    );
  }
}
