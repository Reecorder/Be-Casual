import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';

class FilterOptionTile extends StatefulWidget {
  FilterOptionTile(
      {super.key, required this.filterList, this.fontSize, this.color});

  List filterList;
  double? fontSize;
  Color? color;

  @override
  State<FilterOptionTile> createState() => _FilterOptionTileState();
}

class _FilterOptionTileState extends State<FilterOptionTile> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        child: SizedBox(
            height: 35,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        // Optional: Tap again to deselect
                        selectedIndex = selectedIndex == index ? null : index;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: isSelected
                                ? (widget.color ?? Colors.blue).withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black12)),
                        child: Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(widget.filterList[index],
                                    style: TextStyle(
                                        color: widget.color ??
                                            AppColors.black.withOpacity(0.9),
                                        fontSize: widget.fontSize ?? 13))))),
                  );
                },
                separatorBuilder: (context, index) {
                  return spacer(width: 5);
                },
                itemCount: widget.filterList.length)));
  }
}
