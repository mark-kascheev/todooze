import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/view/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: _AppbarActionButton(onTap: () => {}, iconPath: 'assets/icons/dots_menu.png'),
      title:  const Center(child: Text('Monday, 27')),
      actions: [
        _AppbarActionButton(onTap: () => context.read<TodooozeTheme>().switchMode(), iconPath: 'assets/icons/calendar.png')
      ],
      elevation: 0.2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
    );
  }
}

class _AppbarActionButton extends StatelessWidget {
  final String iconPath;
  final double iconSize;
  final Function() onTap;
  const _AppbarActionButton({Key? key, required this.iconPath, this.iconSize = 20, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: Image.asset(iconPath, width: iconSize, height: iconSize, color: Theme.of(context).colorScheme.onPrimary));
  }
}

