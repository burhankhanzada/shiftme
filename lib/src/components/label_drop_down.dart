import 'package:flutter/material.dart';

class LabelDropdown<T> extends StatefulWidget {
  final String label;
  final T? initialValue;
  final List<T> valueList;
  final Function(T value)? onSelected;

  const LabelDropdown({
    Key? key,
    required this.label,
    this.initialValue,
    required this.valueList,
    this.onSelected,
  }) : super(key: key);

  @override
  _LabelDropdownState createState() => _LabelDropdownState<T>();
}

class _LabelDropdownState<T> extends State<LabelDropdown<T>> {
  late T _selected = widget.initialValue ?? widget.valueList[0];

  @override
  void initState() {
    widget.onSelected!(_selected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label),
        DropdownButton<T>(
          value: _selected,
          onChanged: (value) {
            setState(() {
              _selected = value as T;
              widget.onSelected!(value);
            });
          },
          items: widget.valueList
              .map(
                (value) => DropdownMenuItem<T>(
                  value: value,
                  child: Text(value.toString()),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
