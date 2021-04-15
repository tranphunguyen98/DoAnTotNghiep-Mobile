import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/screen/detail_habit/detail_info_habit_container.dart';
import 'package:totodo/presentation/screen/detail_habit/slide_to_confirm.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class HabitDetailScreen extends StatefulWidget {
  @override
  _HabitDetailScreenState createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  final _controller = ScrollController();

  double get maxHeight => MediaQuery.of(context).size.height;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar();
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              stretch: true,
              flexibleSpace: Header(
                maxHeight: maxHeight,
                minHeight: minHeight,
              ),
              expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
            ),
            SliverFillRemaining(child: DetailInfoHabitContainer()),
          ],
        ),
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  Header({Key key, this.maxHeight, this.minHeight}) : super(key: key);
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);
        return _buildContainerCheck();
        return Stack(
          fit: StackFit.expand,
          children: [
            _buildOpacity(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomLeft, end: Alignment.bottomCenter)
          .evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(bottom: 16, left: 64, right: 64.0),
        child: Text(
          "Thiền",
          style: TextStyle(
            fontSize: Tween<double>(begin: 18, end: 24).evaluate(animation),
            color: ColorTween(begin: Colors.black87, end: Colors.white)
                .evaluate(animation),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOpacity(Animation<double> animation) {
    return Opacity(
      opacity: Tween<double>(begin: 1, end: 0.0).evaluate(animation),
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Widget _buildContainerCheck() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: kColorGreenLight,
      height: MediaQuery.of(_context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 220.0),
            Image.asset(
              kImageTag,
              width: 160.0,
              height: 160.0,
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              "Chống đẩy",
              style: kFontSemiboldWhite_18,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "Giấc mơ sẽ không bao giờ thành hiện thực\ntrừ khi bạn bắt tay vào làm",
              style: kFontRegularWhite_14_80,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.0,
            ),
            ConfirmationSlider(
              onConfirmation: () {},
              height: 56.0,
              text: '',
              backgroundColor: Colors.white.withOpacity(0.3),
              foregroundColor: Colors.white,
              iconColor: kColorGreenLight,
            ),
            SizedBox(
              height: 32.0,
            ),
            LinearPercentIndicator(
              padding: EdgeInsets.all(4.0),
              width: 120.0,
              lineHeight: 6.0,
              alignment: MainAxisAlignment.center,
              percent: 0.5,
              backgroundColor: Colors.white.withOpacity(0.3),
              progressColor: Colors.white,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "15/30 Count",
              style: kFontRegularWhite_12_80,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 6.0,
            ),
            CircleInkWell(
              Icons.keyboard_arrow_up,
              onPressed: () {},
              color: kColorWhite,
              size: 36.0,
            ),
          ],
        ),
      ),
    );
  }
}
