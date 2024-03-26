import 'package:flutter/material.dart';

class customDropdownButtonClass extends StatelessWidget {
  List<String> values;
  double width;

  customDropdownButtonClass({required this.values, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      decoration: BoxDecoration(
        color: Color.fromARGB(53, 53, 53, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        underline: Container(),
        value: values.first,
        dropdownColor: const Color.fromRGBO(53, 53, 53, 1.0),
        style: const TextStyle(color: Colors.white),
        onChanged: (_) {},
        items: values
            .map(
              (item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                )
                ) //map
            .toList(),
      ),
    );
  }
}
