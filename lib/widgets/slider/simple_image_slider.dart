import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/slider/dot_image_indicator.dart';

class ImageSliderWidget extends StatefulWidget{
  final List<String> imageUrls;
  final BorderRadius imageBorderRadius;
  final double imageHeight;

  const ImageSliderWidget({
    Key key,
    @required this.imageUrls,
    @required this.imageBorderRadius,
    this.imageHeight = 350.0,
  }) : super(key:key);

  @override
  ImageSliderWidgetState createState() => new ImageSliderWidgetState();
}

class ImageSliderWidgetState extends State<ImageSliderWidget>{
  List<Widget> _pages = [];
  int page = 0;
  final _controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = widget.imageUrls.map((url){
      return _buildImagePageItem(url);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildingImageSlider();
  }

  Widget _buildingImageSlider(){
    return Container(
      height: 250.0,
      padding: EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
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
      bottom: 20.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          color: Colors.white,
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

  Widget _buildImagePageItem(String imgUrl){
    return ClipRRect(
      borderRadius: widget.imageBorderRadius,
      child: Image.asset(
        imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}