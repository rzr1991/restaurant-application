import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurants/common/styles.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.focusNode,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            offset: Offset(1, 5),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
            Flexible(
              child: TextField(
                controller: controller,
                focusNode: widget.focusNode,
                style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
                decoration: const InputDecoration(
                  hintText: 'Search restaurant...',
                ),
                onChanged: widget.onChanged,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
