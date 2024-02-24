import 'package:flutter/material.dart';

class SelectWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(dynamic) onChange;
  final dynamic value;

  const SelectWidget({Key? key, required this.items, required this.onChange, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: items.map((item) {
        return GestureDetector(
          onTap: () => onChange(item['id']),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: (value == item['id']) ? Theme.of(context).primaryColor : Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              item['name'].toString(),
              style: TextStyle(
                color: (value == item['id']) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
