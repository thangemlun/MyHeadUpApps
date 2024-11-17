import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class PopUpFilterMenu extends StatelessWidget {

  final PopupMenuItemBuilder<String> itemBuilder;

  final PopupMenuItemSelected? onSelect;

  const PopUpFilterMenu({required this.itemBuilder, this.onSelect});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<String>(
      enabled: onSelect != null,
      onSelected: onSelect,
      itemBuilder: itemBuilder,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Icon(Boxicons.bx_dots_vertical)),
    );
  }
}
