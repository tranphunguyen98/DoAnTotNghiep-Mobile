import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String label;
  final double percent;
  final double percentIncrease;
  final double percentDecrease;

  const Indicator(
      {Key key,
      this.color,
      this.label,
      this.percent,
      this.percentIncrease,
      this.percentDecrease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: 8.0,
          color: color,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          label,
          style: kFontMediumBlack_12,
        ),
        if (percent != null)
          Text(
            ' - $percent%',
            style: kFontRegularDefault_12,
          ),
        if (percentIncrease != null || percentDecrease != null) Spacer(),
        if (percentIncrease != null)
          Row(
            children: [
              Text('$percentIncrease%', style: kFontRegularDefault_12),
              Icon(
                Icons.arrow_upward,
                size: 8.0,
                color: Colors.green,
              )
            ],
          ),
        if (percentDecrease != null)
          Row(
            children: [
              Text('$percentDecrease%', style: kFontRegularDefault_12),
              Icon(
                Icons.arrow_downward,
                size: 8.0,
                color: Colors.red,
              )
            ],
          )
      ],
    );
  }
}
