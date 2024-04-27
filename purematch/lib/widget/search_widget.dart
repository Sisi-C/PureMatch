import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    required this.text,
    required this.onChanged,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Color.fromRGBO(230, 230, 230, 1));
    const styleHint = TextStyle(color: Colors.white70);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(44, 45, 48, 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Align(
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: style.color),
              hintText: widget.hintText,
              hintStyle: style,
              border: InputBorder.none,
            ),
            style: style,
            onChanged: widget.onChanged,
          ),
        ));
  }
}
