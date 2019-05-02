import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/slider/dot_image_indicator.dart';

class WidgetSliderWidget extends StatefulWidget{
  final List<Widget> widgets;
  final BorderRadius imageBorderRadius;
  final double widgetHeight;

  const WidgetSliderWidget({
    Key key,
    @required this.widgets,
    @required this.imageBorderRadius,
    @required this.widgetHeight,
  }) : super(key:key);

  @override
  WidgetSliderWidgetState createState() => new WidgetSliderWidgetState();
}

class WidgetSliderWidgetState extends State<WidgetSliderWidget>{
  List<Widget> _pages = [];
  int page = 0;
  final _controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = widget.widgets.map((widget){
      return _buildWidgetPageItem(widget);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildingWidgetSlider(context);
  }

  Widget _buildingWidgetSlider(BuildContext context){
    return Container(
      height: widget.widgetHeight,
      padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 3.0,
        child: Stack(
          children: <Widget>[
            _buildPagerViewSlider(),
            _buildDotsIndicatorOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagerViewSlider(){
    return Positioned.fill(
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index){
          return _pages[index % _pages.length];
        },
        onPageChanged: (int p){
          setState(() {
            page = p;
          });
        },
      ),
    );
  }

  Positioned _buildDotsIndicatorOverlay(){
    return Positioned(
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          color: Colors.black38,
          onPageSelected: (int page){
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }

  Widget _buildWidgetPageItem(Widget widgets){
    return ClipRRect(
      borderRadius: widget.imageBorderRadius,
      child: widgets,
    );
  }
}