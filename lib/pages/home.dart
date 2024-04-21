import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';
import 'package:my_project/widgets/students_grid.dart';

class HomePage extends StatefulWidget {
  final List<Student> students;
  final Duration animationDuration;
  const HomePage({
    Key? key,
    required this.students,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String> selectedrole = [];
  List<String> selectedrarity = [];
  List<String> selectedschool = [];
  List<String> selectedweaponType = [];
  List<String> selectedcombatClass = [];
  List<String> selectedposition = [];
  List<String> selectedatkType = [];
  List<String> selecteddefType = [];
  List<String> selectedstar = [];
  List<String> selectedoutfit = [];

  late AnimationController controller;

  bool selected_sort = false;

  final List<String> outfits = [
    'Uniform',
    'Bunny Girl',
    'Swimsuit',
    'New Year',
    'Sportswear',
    'Casual',
    'Hot Spring',
    'Christmas',
    'Camping',
    'Dress',
    'Guide',
    'Kid',
    'Riding',
    'Maid',
    'Cheerleader'
  ];

  final List<String> rarity = ['regular', 'anniversary', 'event', 'limited'];

  final List<String> school = [
    'Abydos',
    'Gehenna',
    'Arius',
    'Millennium',
    'SRT',
    'Valkyrie',
    'Hyakkiyako',
    'Shanhaijing',
    'ETC',
    'Sakugawa',
    'Tokiwadai',
    'Red Winter',
    'Trinity'
  ];

  final List<String> Weapontype = [
    'SG',
    'SMG',
    'AR',
    'GL',
    'HG',
    'RL',
    'SR',
    'RG',
    'MG',
    'MT',
    'FT'
  ];

  final List<String> role = ['Striker', 'Special'];

  final List<String> combat_class = [
    'Tank',
    'Dealer',
    'Healer',
    'Support',
    'Tactical'
  ];

  final List<String> position = ['Back', 'Middle', 'Front'];

  final List<String> atkType = ['Explosive', 'Penetration', 'Mystic', 'Sonic'];

  final List<String> defType = [
    'Light Armor',
    'Heavy Armor',
    'Special Armor',
    'Elastic Armor'
  ];

  final List<String> star = ["1", "2", "3"];

  final List<String> sort_option = ["Name"];

  String selectedOption = "Name";

  bool reverse_sort = false;

  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    controller.dispose();
  }

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    List<String> filterList(List<String> items, List<String> selectedItems) {
      Set<String> selectedSet = selectedItems.toSet();

      return items
          .where((item) => selectedSet.isEmpty || selectedSet.contains(item))
          .toList();
    }

    // Filter the lists based on the selected filters
    final filtedRole = filterList(role, selectedrole);
    final filtedRarity = filterList(rarity, selectedrarity);
    final filtedCombat_Class = filterList(combat_class, selectedcombatClass);
    final filtedStar = filterList(star, selectedstar);
    final filtedAtkType = filterList(atkType, selectedatkType);
    final filtedDefType = filterList(defType, selecteddefType);
    final filtedPosition = filterList(position, selectedposition);
    final filtedSchool = filterList(school, selectedschool);
    final filtedWeaponType = filterList(Weapontype, selectedweaponType);
    final filtedOutfits = filterList(outfits, selectedoutfit);

    String searchStudent = _textController.text;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Students',
          style: theme.textTheme.headline6,
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: Container(
        color: theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              color: const Color.fromARGB(255, 58, 58, 58),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: _visible
                          ? Colors.white
                          : Colors.black.withOpacity(0.7),
                    ),
                    padding: EdgeInsets.all(1),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                          _visible
                              ? controller.forward()
                              : controller.reverse();
                        });
                      },
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: controller,
                        size: 30,
                        color: _visible ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        setState(() {
                          searchStudent = value; // Update the search query
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Filter by name',
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.7),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            _myDrawer(),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Center(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          'assets/Blue_Archive/components/schale.png',
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: StudentGrid(
                      students: widget.students,
                      filtedRole: filtedRole,
                      filtedRarity: filtedRarity,
                      filtedCombat_Class: filtedCombat_Class,
                      filtedstar: filtedStar,
                      filtedatkType: filtedAtkType,
                      filteddefType: filtedDefType,
                      filtedposition: filtedPosition,
                      filtedschool: filtedSchool,
                      filtedweaponType: filtedWeaponType,
                      filtedoutfits: filtedOutfits,
                      reverse_sort: reverse_sort,
                      searchStudent: searchStudent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myDrawer() {
    return AnimatedContainer(
        duration: widget.animationDuration,
        height: _visible ? 300 : 0,
        child: Visibility(
            visible: _visible,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    sort_Container(),
                    Filt_Container("Role:", role, '', selectedrole),
                    Filt_Container(
                        "Combat Class:",
                        combat_class,
                        'assets/Blue_Archive/components/class_icons/',
                        selectedcombatClass),
                    Filt_Container("Rarity:", rarity, '', selectedrarity),
                    Filt_Container(
                        "Star:",
                        star,
                        'assets/Blue_Archive/components/Star_Icon.webp',
                        selectedstar),
                    Filt_Container(
                        "Attack Type:", atkType, '', selectedatkType),
                    Filt_Container(
                        "Defense Type:", defType, '', selecteddefType),
                    Filt_Container("Position:", position, '', selectedposition),
                    Filt_Container(
                        "Academy:",
                        school,
                        'assets/Blue_Archive/components/school_icons/',
                        selectedschool),
                    Filt_Container(
                        "Weapon Type:", Weapontype, '', selectedweaponType),
                    Filt_Container("Outfits:", outfits, '', selectedoutfit),
                  ],
                ))));
  }

  Widget Filt_Container(
    String topic,
    List<String> mylist,
    String img,
    List<String> selection,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(topic),
          Container(
            child: Wrap(
              spacing: 6,
              children: mylist.map((index) {
                final assetPath = index != 'Sakugawa'
                    ? '${img}${index}.png'
                    : '${img}ETC.png';
                bool isSelected = selection.contains(index);
                return FilterChip(
                  selected: isSelected,
                  label: topic.contains('Star')
                      ? listStar(int.parse(index))
                      : Text(index),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selection.add(index);
                      } else {
                        selection.remove(index);
                      }
                    });
                  },
                  selectedColor: Colors.white, // Change selected chip color
                  backgroundColor: Colors.black, // Change unselected chip color
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                  showCheckmark: false,
                  avatar: !topic.contains('Star')
                      ? (topic.contains('Academy') || topic.contains('Combat')
                          ? Image.asset(
                              assetPath,
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                              color: isSelected ? Colors.black : Colors.white,
                            )
                          : null)
                      : null,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget listStar(int starCount) {
    return Container(
        width: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            starCount,
            (index) => Image.asset(
              'assets/Blue_Archive/components/Star_Icon.webp',
              height: 20,
            ),
          ),
        ));
  }

  Widget sort_Container() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Sort by'),
          Container(
            child: Wrap(
              spacing: 8, // Adjust spacing as needed
              children: sort_option.map((option) {
                bool _myselected = selected_sort == option;
                return ChoiceChip(
                  label: Text(option),
                  selected: _myselected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedOption = option;
                        if (selectedOption == option) {
                          reverse_sort = !reverse_sort;
                        }
                      } else {
                        selectedOption = '';
                      }
                    });
                  },
                  avatar: Icon(
                    reverse_sort ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                  selectedColor: Colors.white,
                  // backgroundColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
