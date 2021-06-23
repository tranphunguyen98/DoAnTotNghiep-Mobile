import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String label;
  final int value;
  final double percentIncrease;
  final double percentDecrease;

  const Indicator(
      {Key key,
      this.color,
      this.label,
      this.value,
      this.percentIncrease,
      this.percentDecrease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: color,
          height: 38,
          width: 4,
        ),
        SizedBox(
          width: 8.0,
        ),
        SizedBox(
          height: 38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: kFontMediumGray_12,
              ),
              Spacer(),
              Text(
                '$value',
                style: kFontSemiboldBlack_14,
              ),
            ],
          ),
        ),
        // if (percentIncrease != null || percentDecrease != null) Spacer(),
        // if (percentIncrease != null)
        //   Row(
        //     children: [
        //       Text('$percentIncrease%', style: kFontRegularDefault_12),
        //       Icon(
        //         Icons.arrow_upward,
        //         size: 8.0,
        //         color: Colors.green,
        //       )
        //     ],
        //   ),
        // if (percentDecrease != null)
        //   Row(
        //     children: [
        //       Text('$percentDecrease%', style: kFontRegularDefault_12),
        //       Icon(
        //         Icons.arrow_downward,
        //         size: 8.0,
        //         color: Colors.red,
        //       )
        //     ],
        //   )
      ],
    );
  }
}
