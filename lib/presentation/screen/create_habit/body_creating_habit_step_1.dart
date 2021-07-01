import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totodo/bloc/create_habit/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

import '../../../utils/my_const/color_const.dart';
import '../../../utils/my_const/font_const.dart';
import '../../../utils/util.dart';
import '../../custom_ui/custom_ui.dart';

class BodyCreatingHabitStep1 extends StatefulWidget {
  final Habit _habit;

  const BodyCreatingHabitStep1(this._habit);

  @override
  _BodyCreatingHabitStep1State createState() => _BodyCreatingHabitStep1State();
}

class _BodyCreatingHabitStep1State extends State<BodyCreatingHabitStep1> {
  CreateHabitBloc _createHabitBloc;
  CreateHabitState _state;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _textIconController = TextEditingController();

  final picker = ImagePicker();
  bool isIcon;
  Color textIconColor = Colors.greenAccent;
  String icon;

  @override
  void initState() {
    _createHabitBloc = BlocProvider.of<CreateHabitBloc>(context);
    _nameController.text =
        _createHabitBloc.state.habit?.name ?? widget._habit?.name ?? '';
    _quoteController.text =
        (_createHabitBloc.state.habit?.motivation?.content?.isNotEmpty ?? false)
            ? _createHabitBloc.state.habit?.motivation?.content
            : widget._habit?.motivation?.content ?? '';

    icon = _createHabitBloc.state.habit.icon?.iconImage;
    if (widget._habit?.icon?.iconText?.isNotEmpty ?? false) {
      isIcon = false;
      _textIconController.text = widget._habit.icon.iconText;
      textIconColor = HexColor(widget._habit.icon.iconColor);
    } else {
      _textIconController.text = 'A';
      isIcon = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateHabitBloc, CreateHabitState>(
      cubit: _createHabitBloc,
      builder: (context, state) {
        _state = state;

        if (_state.loading) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kColorPrimary,
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildName(),
              // _buildCategory(),
              if (isIcon) _buildIcon() else _buildIconText(),
              _buildQuote(),
              _buildImage(),
            ],
          ),
        );
      },
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final List<String> images = [];
        images.addAll(_state.habit.motivation.images ?? []);
        images.add(imageFile.path);

        _createHabitBloc.add(
          CreatingHabitDataChanged(
            motivation: _state.habit.motivation.copyWith(
              images: images,
            ),
          ),
        );
      }
    });
  }

  Widget _buildName() {
    if (icon == null && (_state.habit.icon.iconImage?.length ?? 0) > 2) {
      icon = _state.habit.icon.iconImage;
    }
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tên Thói Quen',
              style: kFontMediumBlack_14,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _buildNameTextField(),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isIcon = true;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(48),
                        ),
                        boxShadow: [
                          if (isIcon)
                            BoxShadow(
                              color: kColorPrimary,
                              spreadRadius: 3,
                              blurRadius: 3,
                              // offset: Offset(0, 1), // changes position of shadow
                            ),
                        ],
                      ),
                      child: ((icon?.length ?? 0) > 2)
                          ? Image.file(File(icon), width: 48, height: 48)
                          : Image.asset(
                              getAssetIcon(int.parse(
                                  (_state.habit.icon?.iconImage?.isNotEmpty ??
                                          false)
                                      ? _state.habit.icon?.iconImage
                                      : "1")),
                              width: 48,
                              height: 48,
                            )),
                ),
                SizedBox(
                  width: 16.0,
                ),
                _buildTextIcon(_state.habit.icon),
              ],
            )
          ],
        )
        //     if (_state.habit.icon?.iconImage?.isNotEmpty ?? false)
        //
        // else
        //
        //
        // ]

        );
  }

  Widget _buildNameTextField() {
    return TextField(
      style: kFontRegularBlack2_14,
      controller: _nameController,
      onChanged: _onNameHabitChanged,
      decoration: InputDecoration(
        hintText: 'Thiền',
        errorText: _state?.msg?.isNotEmpty ?? false ? _state.msg : null,
        hintStyle: kFontRegularGray1_14,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kColorGray1, width: 0.5),
        ),
      ),
    );
  }

  Widget _buildTextIcon(HabitIcon icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isIcon = false;
        });
      },
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
            color: textIconColor,
            shape: BoxShape.circle,
            boxShadow: [
              if (!isIcon)
                BoxShadow(
                  color: kColorPrimary,
                  spreadRadius: 3,
                  blurRadius: 3,
                  // offset: Offset(0, 1), // changes position of shadow
                ),
            ]),
        child: Center(
            child: Text(
          _textIconController.text,
          style: kFontSemiboldWhite_18,
        )),
      ),
    );
  }

  // Widget _buildCategory() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Phân loại',
  //           style: kFontMediumBlack_14,
  //         ),
  //         const SizedBox(
  //           height: 8.0,
  //         ),
  //         DropdownButton<Map<String, dynamic>>(
  //           isExpanded: true,
  //           value: getHabitTypeFromId(_state.habit.type),
  //           items: kHabitType.map((value) {
  //             return DropdownMenuItem<Map<String, dynamic>>(
  //               value: value,
  //               child: Text(
  //                 value[kKeyHabitTypeLabel] as String,
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: _onTypeHabitChanged,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildIcon() {
    final int indexIcon = int.parse(
            ((_state.habit?.icon?.iconImage?.isNotEmpty ?? false) &&
                    _state.habit.icon.iconImage.length <= 2)
                ? _state.habit?.icon?.iconImage
                : "1") -
        1;
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
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: 50 * 4.0,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemCount: 57,
              itemBuilder: (context, index) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      onIconHabitChanged(index);
                    },
                    child: Image.asset(
                      getAssetIcon(index + 1),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  if (index == indexIcon && isIcon)
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: kColorPrimary.withOpacity(0.8),
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

  Widget _buildIconText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Tên',
            style: kFontRegularGray1_14,
          ),
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 60,
            height: 40,
            child: TextField(
              controller: _textIconController,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _onTextIconChanged();
                  });
                }
              },
              autofocus: true,
              maxLength: 2,
              decoration: InputDecoration(counterText: ""),
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Text(
            'Màu',
            style: kFontRegularGray1_14,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Chọn màu'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: textIconColor,
                          onColorChanged: (value) {
                            setState(() {
                              textIconColor = value;
                              _onTextIconChanged();
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: textIconColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kColorPrimary.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 2,
                      // offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ))
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
          const SizedBox(
            height: 4.0,
          ),
          TextField(
            style: kFontRegularBlack2_14,
            controller: _quoteController,
            onChanged: _onQuoteHabitChanged,
            decoration: InputDecoration(
              hintText: 'Get up and be amazing',
              hintStyle: kFontRegularGray1_14,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kColorGray1, width: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Hình ảnh tạo động lực',
          style: kFontMediumBlack_14,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
          spacing: 8.0,
          children: _getWidgetListMotivationImage(),
        )
      ]),
    );
  }

  List<Widget> _getWidgetListMotivationImage() {
    final List<Widget> widgetList = [];
    final double imageSize = (MediaQuery.of(context).size.width - 80) / 3;

    if (_state.habit?.motivation?.images != null) {
      widgetList.addAll(_state.habit.motivation.images
          .map(
            (image) => Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      File(image),
                      height: imageSize,
                      width: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      _onTap(image);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList());
    }

    widgetList.add(
      GestureDetector(
        onTap: _getImage,
        child: Container(
          height: imageSize,
          width: imageSize,
          margin: const EdgeInsets.only(bottom: 8.0, top: 8, right: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Icon(
            Icons.add_photo_alternate,
            size: 32,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
    return widgetList;
  }

  void _onNameHabitChanged(String value) {
    _createHabitBloc.add(CreatingHabitDataChanged(name: value));
  }

  void _onTextIconChanged() {
    _createHabitBloc.add(CreatingHabitDataChanged(
        icon: HabitIcon(
      iconText:
          _textIconController.text.isNotEmpty ? _textIconController.text : 'A',
      iconColor: getHexFromColor(textIconColor),
    )));
  }

  void _onTypeHabitChanged(Map<String, dynamic> newValue) {
    _createHabitBloc
        .add(CreatingHabitDataChanged(type: newValue[kKeyHabitTypeId] as int));
  }

  void onIconHabitChanged(int index) {
    icon = (index + 1).toString();
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        icon: HabitIcon(
          iconImage: (index + 1).toString(),
        ),
        // type: kHabitType[0][kKeyHabitTypeId] as int,
      ),
    );
  }

  void _onQuoteHabitChanged(String value) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        motivation: _state.habit.motivation.copyWith(
          content: value,
        ),
      ),
    );
  }

  void _onTap(String image) {
    final List<String> images = [];
    images.addAll(_state.habit.motivation.images ?? []);
    images.remove(image);

    _createHabitBloc.add(
      CreatingHabitDataChanged(
        motivation: _state.habit.motivation.copyWith(
          images: images,
        ),
      ),
    );
  }
}
