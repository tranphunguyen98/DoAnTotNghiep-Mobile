import 'package:flutter/material.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ListDayLast7DayRadio extends StatefulWidget {
  final Function(DateTime value) onRadioValueChanged;

  const ListDayLast7DayRadio({
    @required this.onRadioValueChanged,
  });

  @override
  ListDayLast7DayRadioState createState() {
    return ListDayLast7DayRadioState();
  }
}

class ListDayLast7DayRadioState extends State<ListDayLast7DayRadio> {
  List<DateTime> data = [6, 5, 4, 3, 2, 1, 0]
      .map((days) => DateTime.now().add(Duration(days: days)))
      .toList();
  DateTime itemSelected;

  @override
  void initState() {
    itemSelected = data[6];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        children: data.asMap().entries.map(
          (e) {
            if (DateHelper.isSameDay(e.value, DateTime.now())) {
              return Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      itemSelected = data[e.key];
                      widget.onRadioValueChanged(itemSelected);
                    });
                  },
                  child: _ItemRadio(
                    date: data[e.key],
                    isSelected: data[e.key] == itemSelected,
                  ),
                ),
              );
            }

            return Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    itemSelected = data[e.key];
                    widget.onRadioValueChanged(itemSelected);
                  });
                },
                child: _ItemRadio(
                  date: data[e.key],
                  isSelected: data[e.key] == itemSelected,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class _ItemRadio extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  const _ItemRadio({this.date, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return DateHelper.isSameDay(date, DateTime.now())
        ? Container(
            height: 42.0,
            width: 84.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color:
                  isSelected ? kColorPrimary : kColorPrimary.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(42.0)),
            ),
            child: Center(
              child: Text(
                'Today',
                style: kFontMediumWhite_14,
              ),
            ),
          )
        : Container(
            height: 42.0,
            width: 42.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: isSelected ? kColorPrimary : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(36.0)),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      DateHelper.getNameOfDay(date).substring(0, 3),
                      style: TextStyle(
                        color: isSelected ? kColorWhite : kColorGray1,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: isSelected ? kColorWhite : kColorBlack2,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          );
  }
}
