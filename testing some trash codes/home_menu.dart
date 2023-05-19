import 'package:flutter/material.dart';

enum MenuType { photographer, makeupArtist, places, list, suits, dresses }

class MenuSelection extends StatefulWidget {
  const MenuSelection({Key? key}) : super(key: key);

  @override
  _MenuSelectionState createState() => _MenuSelectionState();
}

class _MenuSelectionState extends State<MenuSelection> {
  MenuType? _selectedMenu;

  final List<RoleOption> _roleOptions = [
    const RoleOption(
      iconPath: 'assets/images/icons8-professional-photographer-48.png',
      type: MenuType.photographer,
    ),
    const RoleOption(
      iconPath: 'assets/images/icons8-makeup-brush-48.png',
      type: MenuType.makeupArtist,
    ),
    const RoleOption(
      iconPath: 'assets/images/icons8-romantic-place.gif',
      type: MenuType.places,
    ),
    const RoleOption(
      iconPath: 'assets/images/icons8-wedding-dress-40.png',
      type: MenuType.dresses,
    ),
    const RoleOption(
      iconPath: 'assets/images/wedding-suit-8996.png',
      type: MenuType.suits,
    ),
    const RoleOption(
      iconPath: 'assets/images/icons8-wish-list-40.png',
      type: MenuType.list,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _roleOptions
          .map(
            (option) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMenu = option.type;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _selectedMenu == option.type
                      ? const Color(0xffF7C8E0)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      option.iconPath,
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class RoleOption {
  final String iconPath;
  final MenuType type;

  const RoleOption({
    required this.iconPath,
    required this.type,
  });
}
