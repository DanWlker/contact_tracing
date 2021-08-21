import 'dart:ui';

import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget{

  Function onItemTap;

  NavDrawer(this.onItemTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          children: [
            ListTile(
              title: navTextComponent("Proximity Detection"),
              onTap: () {
                onItemTap(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: navTextComponent("Blockchain Sync"),
              onTap: () {
                onItemTap(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: navTextComponent("Settings"),
              onTap: () {
                onItemTap(2);
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }

  Text navTextComponent(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 17
      ),
    );
  }
}