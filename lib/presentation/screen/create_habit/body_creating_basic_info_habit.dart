import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class BodyCreatingBasicInfoHabit extends StatefulWidget {
  @override
  _BodyCreatingBasicInfoHabitState createState() =>
      _BodyCreatingBasicInfoHabitState();
}

class _BodyCreatingBasicInfoHabitState
    extends State<BodyCreatingBasicInfoHabit> {
  String dropdownValue = kListCategory.first;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildName(),
          _buildCategory(),
          _buildIcon(),
          _buildQuote(),
          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tên Thói Quen',
            style: kFontMediumBlack_14,
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Image.asset(
                kIconMeditation,
                width: 48,
                height: 48,
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextField(
                  style: kFontRegularBlack2_14,
                  decoration: InputDecoration(
                    hintText: 'Thiền',
                    hintStyle: kFontRegularGray1_14,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: kColorGray1,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân loại',
            style: kFontMediumBlack_14,
          ),
          SizedBox(
            height: 8.0,
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            items: kListCategory.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {},
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, top: 16.0, bottom: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon',
            style: kFontMediumBlack_14,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 52 * 3.0,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemCount: 36,
              itemBuilder: (context, index) => Stack(
                children: [
                  Image.asset(
                    kIconMeditation,
                    width: 52,
                    height: 52,
                  ),
                  if (index == 0)
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: kColorPrimary.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.check,
                            color: kColorWhite,
                            size: 12.0,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuote() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Câu nói tạo động lực',
            style: kFontMediumBlack_14,
          ),
          SizedBox(
            height: 4.0,
          ),
          TextField(
            style: kFontRegularBlack2_14,
            decoration: InputDecoration(
              hintText: 'Get up and be amazing',
              hintStyle: kFontRegularGray1_14,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: kColorGray1, width: 0.5, style: BorderStyle.solid),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Hình ảnh tạo động lực',
          style: kFontMediumBlack_14,
        ),
        SizedBox(
          height: 16.0,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            kImageMotivation,
          ),
        )
      ]),
    );
  }
}
