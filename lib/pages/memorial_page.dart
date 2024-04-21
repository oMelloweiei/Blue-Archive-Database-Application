import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/models/student.dart';

class Memorial_Lobby extends StatefulWidget {
  final List<Student> students;

  const Memorial_Lobby({
    Key? key,
    required this.students,
  }) : super(key: key);

  @override
  State<Memorial_Lobby> createState() => _MemorialLobbyState();
}

class _MemorialLobbyState extends State<Memorial_Lobby> {
  bool _onShow = false;
  late String _selectedFullImg;
  late Student _selectedStudent;

  @override
  void initState() {
    super.initState();
    _selectedFullImg = "";
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // Define the height here
        child: AppBar(
          title: Text(
            'Memorials Lobby',
            style: theme.textTheme.headline6,
          ),
          backgroundColor: theme.colorScheme.background,
        ),
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              color: theme.colorScheme.background,
              child: myList()),
          if (_onShow)
            Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _onShow = false;
                        });
                      },
                    ),
                  ),
                  FullImage(
                      _selectedFullImg), // Display the full image on top of the overlay
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget myList() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: widget.students.length,
      itemBuilder: (context, index) {
        widget.students.sort((a, b) => a.name.compareTo(b.name));
        final Student student = widget.students[index];
        final studentName =
            student.name.replaceAll(' ', '_').replaceAll(RegExp(r'[()]'), '');

        final String imagePath =
            "assets/Blue_Archive/characters/memorial_lobby_icons/${studentName}_Icon_2.webp";
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedStudent = widget.students[index];
              final selectedStudentName = _selectedStudent.name
                  .replaceAll(' ', '_')
                  .replaceAll(RegExp(r'[()]'), '');
              _selectedFullImg =
                  "assets/Blue_Archive/characters/memorial_lobby/${selectedStudentName}.jpg";
              _onShow = true;
            });
          },
          child: Image.asset(imagePath),
        );
      },
    );
  }
}

class FullImage extends StatefulWidget {
  final String img;

  const FullImage(this.img);

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  bool _onImgShow = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _onImgShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(
        top: _onImgShow ? 0 : 10,
      ),
      child: AnimatedOpacity(
        opacity: _onImgShow ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: Image.asset(
          widget.img,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
