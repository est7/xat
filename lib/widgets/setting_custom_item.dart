import 'package:flutter/material.dart';

class SettingCustomItem extends StatelessWidget {
  const SettingCustomItem({
    Key? key,
    required this.title,
    required this.onClick,
    this.description,
    this.position = Position.middle,
  }) : super(key: key);

  final String title;
  final String? description;
  final Function onClick;
  final Position position;

  @override
  Widget build(BuildContext context) {
    final isTopRounded =
        position == Position.first || position == Position.single;
    final isBottomRounded =
        position == Position.last || position == Position.single;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: buildBorderRadius(isTopRounded, isBottomRounded)),
      child: InkWell(
        onTap: () => onClick(),
        borderRadius: buildBorderRadius(isTopRounded, isBottomRounded),
        child: SizedBox(
          height: 72,
          child: Align(
            alignment: Alignment.center,
            child: ListTile(
              leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.settings)),
              title: Text(title),
              subtitle: description != null ? Text(description!) : null,
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius buildBorderRadius(bool isTopRounded, bool isBottomRounded) {
    return BorderRadius.vertical(
      top: Radius.circular(isTopRounded ? 12 : 0),
      bottom: Radius.circular(isBottomRounded ? 12 : 0),
    );
  }
}

enum Position {
  single,
  first,
  last,
  middle,
}
