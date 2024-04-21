import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/student.dart';

class Attributes extends StatelessWidget {
  final Student student;
  final String imageSchoolPath;
  final Color atkColor;
  final Color defColor;

  const Attributes({
    Key? key,
    required this.student,
    required this.imageSchoolPath,
    required this.atkColor,
    required this.defColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = student.name.replaceAll('(', '').replaceAll(')', '');
    final memorialLobbyIcons =
        'assets/Blue_Archive/characters/memorial_lobby/${name.replaceAll(' ', '_')}.jpg';

    final String onlyName =
        name.contains(' ') ? name.replaceAll(' ${student.outfit}', '') : name;

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _buildTypeContainer(
                    'assets/Blue_Archive/components/atk_def_icons/Type_Attack.png',
                    student.atkType,
                    atkColor,
                  ),
                  const SizedBox(height: 10),
                  _buildTypeContainer(
                    'assets/Blue_Archive/components/atk_def_icons/Type_Defense.png',
                    student.defType,
                    defColor,
                  ),
                ],
              ),
              _buildPositionContainer(student.position, onlyName),
              _buildIconContainer(
                'assets/Blue_Archive/components/class_icons/${student.combat}.png',
                student.combat,
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildSchoolContainer(
            imageSchoolPath,
            student.school,
            student.club,
          ),
          const SizedBox(height: 5),
          _buildWeaponAndPlaceContainer(onlyName, student),
          _buildEquipmentContainer(
              student.firstslot, student.secondslot, student.thirdslot),
          const SizedBox(height: 20),
          _buildMemorialContainer(memorialLobbyIcons)
        ],
      ),
    );
  }

  Widget _buildIconContainer(String imagePath, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.cover, height: 60),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPositionContainer(String position, String name) {
    final String haloImagePath =
        'assets/Blue_Archive/characters/Halo/${name}_Halo.webp';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        children: [
          name != 'Umika'
              ? Image.asset(
                  haloImagePath,
                  height: 60,
                  width: 60,
                )
              : Container(width: 60, height: 40, child: Text('None')),
          SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFF2B4564),
            ),
            child: Text(
              position,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTypeContainer(String imagePath, String text, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 25),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolContainer(String imagePath, String school, String club) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Row(
        children: [
          imagePath !=
                  'assets/Blue_Archive/components/school_icons/Sakugawa.png'
              ? Image.asset(imagePath, height: 40)
              : Image.asset(
                  'assets/Blue_Archive/components/school_icons/ETC.png',
                  height: 40),
          const SizedBox(width: 10),
          Text(
            '$school /\n$club',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponAndPlaceContainer(String onlyName, Student student) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/Blue_Archive/components/firearm_icons/Combat_Icon_Cover_Ally.png',
                        height: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        student.weaponType,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Blue_Archive/characters/weapons/$onlyName.webp',
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
          _buildPlaceIcons(student),
        ],
      ),
    );
  }

  Widget _buildPlaceIcons(Student student) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildPlaceColumn("City", student.city),
          SizedBox(width: 5),
          _buildPlaceColumn("Desert", student.outdoor),
          SizedBox(width: 5),
          _buildPlaceColumn("Indoor", student.indoor),
        ],
      ),
    );
  }

  Widget _buildPlaceColumn(String terrain, String placeType) {
    return Column(
      children: [
        Image.asset(
          'assets/Blue_Archive/components/place_icons/${terrain}_Icon.webp',
          fit: BoxFit.cover,
          width: 35,
        ),
        Image.asset(
          'assets/Blue_Archive/components/affinity_icons/${placeType}_Icon.webp',
          fit: BoxFit.cover,
          width: 35,
        ),
      ],
    );
  }

  Widget _buildEquipmentContainer(String first, String second, String third) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildEquipmentSlot(first),
          _buildEquipmentSlot(second),
          _buildEquipmentSlot(third),
        ],
      ),
    );
  }

  Widget _buildEquipmentSlot(String slot) {
    return ClipOval(
      child: Container(
        height: 90,
        width: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Image.asset(
          'assets/Blue_Archive/components/equipment/$slot.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMemorialContainer(String img) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text('Memorial Lobby', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              img,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
