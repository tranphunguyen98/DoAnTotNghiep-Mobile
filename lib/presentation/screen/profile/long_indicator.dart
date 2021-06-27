import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

enum IndicatorTypeEnum {
  kValue,
  kPercent,
}

class CompareIndicator extends StatelessWidget {
  final String label;
  final double value;
  final IndicatorTypeEnum type;

  const CompareIndicator({
    Key key,
    @required this.label,
    @required this.value,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null)
          Text(
            '${value >= 0 ? 'Tăng' : 'Giảm'}${' ${value.abs().toInt()}${type == IndicatorTypeEnum.kPercent ? '%' : ''} $label'}',
            style: kFontRegularDefault_10,
          ),
        SizedBox(
          width: 2,
        ),
        if (value >= 0)
          Icon(
            Icons.arrow_upward,
            size: 8.0,
            color: Colors.green,
          ),
        if (value < 0)
          Icon(
            Icons.arrow_downward,
            size: 8.0,
            color: Colors.red,
          )
      ],
    );
  }
}
