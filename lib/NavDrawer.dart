import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget{

  Function onItemTap;
  List<String> navigationTitles;

  NavDrawer(this.onItemTap, this.navigationTitles);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          children: navigationComponentList(context),
        )
    );
  }

  List<Widget> navigationComponentList(BuildContext context) {
    List<Widget> temp = [];
    navigationTitles.asMap().forEach((index, element) {
      temp.add(
        navigationComponent(context, element, index)
      );
    });

    return temp;
  }

  ListTile navigationComponent(BuildContext context, String title, int index) {
    return ListTile(
      title: navTextComponent(title),
      onTap: () {
        onItemTap(index);
        Navigator.pop(context);
      },
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