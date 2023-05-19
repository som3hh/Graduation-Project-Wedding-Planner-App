import 'package:flutter/material.dart';

enum RoleType { photographer, makeupArtist, shop, client }

class RoleSelection extends StatefulWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  _RoleSelectionState createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  RoleType? _selectedRole;

  final List<RoleOption> _roleOptions = [
    const RoleOption(
      title: 'Photographer',
      iconPath: 'assets/images/icons8-professional-photographer-48.png',
      type: RoleType.photographer,
    ),
    const RoleOption(
      title: 'Makeup Artist',
      iconPath: 'assets/images/icons8-makeup-brush-48.png',
      type: RoleType.makeupArtist,
    ),
    const RoleOption(
      title: 'Shop',
      iconPath: 'assets/images/icons8-shop-48.png',
      type: RoleType.shop,
    ),
    const RoleOption(
      title: 'Client',
      iconPath: 'assets/images/icons8-romance-48.png',
      type: RoleType.client,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _roleOptions
          .map(
            (option) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = option.type;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _selectedRole == option.type
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
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      option.title,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedRole == option.type
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
  final String title;
  final String iconPath;
  final RoleType type;

  const RoleOption({
    required this.title,
    required this.iconPath,
    required this.type,
  });
}
