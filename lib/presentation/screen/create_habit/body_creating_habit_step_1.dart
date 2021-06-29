import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totodo/bloc/create_habit/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

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

  final picker = ImagePicker();

  @override
  void initState() {
    _createHabitBloc = BlocProvider.of<CreateHabitBloc>(context);
    _nameController.text =
        _createHabitBloc.state.habit?.name ?? widget._habit?.name ?? '';
    _quoteController.text = _createHabitBloc.state.habit?.motivation?.text ??
        widget._habit?.motivation?.text ??
        '';
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

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildName(),
              // _buildCategory(),
              _buildIcon(),
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
          Row(
            children: [
              Image.asset(
                _state.habit?.icon?.iconImage ?? kListIconDefault.first,
                width: 48,
                height: 48,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextField(
                  style: kFontRegularBlack2_14,
                  controller: _nameController,
                  onChanged: _onNameHabitChanged,
                  decoration: InputDecoration(
                    hintText: 'Thiền',
                    errorText:
                        _state?.msg?.isNotEmpty ?? false ? _state.msg : null,
                    hintStyle: kFontRegularGray1_14,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kColorGray1, width: 0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          const SizedBox(
            height: 8.0,
          ),
          DropdownButton<Map<String, dynamic>>(
            isExpanded: true,
            value: getHabitTypeFromId(_state.habit.type),
            items: kHabitType.map((value) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: value,
                child: Text(
                  value[kKeyHabitTypeLabel] as String,
                ),
              );
            }).toList(),
            onChanged: _onTypeHabitChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    final int indexIcon = kListIconDefault
        .indexOf(_state?.habit?.icon?.iconImage ?? kIconMeditation);
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
            height: 50 * 2.0,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemCount: kListIconDefault.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      onIconHabitChanged(index);
                    },
                    child: Image.asset(
                      kListIconDefault[index],
                      width: 50,
                      height: 50,
                    ),
                  ),
                  if (index == indexIcon)
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
                      fit: BoxFit.fitWidth,
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

  void _onTypeHabitChanged(Map<String, dynamic> newValue) {
    _createHabitBloc
        .add(CreatingHabitDataChanged(type: newValue[kKeyHabitTypeId] as int));
  }

  void onIconHabitChanged(int index) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        icon: HabitIcon(
          iconImage: kListIconDefault[index],
        ),
        type: kHabitType[0][kKeyHabitTypeId] as int,
      ),
    );
  }

  void _onQuoteHabitChanged(String value) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        motivation: _state.habit.motivation.copyWith(
          text: value,
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
