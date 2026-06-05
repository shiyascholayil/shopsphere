import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
class ListTiles extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool selected;
  const ListTiles({
    super.key,
    required this.text,
    required this.onTap,
    required this.selected
  });

  @override
  Widget build(BuildContext context) {
    return
       ListTile(

        title: Text(text,style:TextStyle(
          color:selected?secondaryColor:primaryColor,
        ) ,),
        tileColor: selected?primaryColor:secondaryColor,
        onTap:onTap,
      

    );
  }
}