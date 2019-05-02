import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/common/flutter_flip_view.dart';
import 'package:share/share.dart';

class ReportItem extends StatefulWidget {
  @override
  _ReportItemState createState() => new _ReportItemState();
}

class _ReportItemState extends State<ReportItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
          print('complete  ${_focusNode.hasFocus}');
        });
      }else if(_focusNode.hasFocus && !_animationController.isCompleted){
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: FlipView(
              animationController: _curvedAnimation,
              front: _buildFrontSide(),
              back: _buildBackSide(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontSide() {
    return AspectRatio(
      aspectRatio: 0.6,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '2019-5-1 健康周报',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(height: 1, color: Colors.grey),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("车道线 实线碾压次数 共 6 次"),
                      subtitle: Text("超过87.30%同驾龄司机"),
                      trailing: Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("交通信号灯 闯红灯次数 共 0 次"),
                      subtitle: Text("超过99.99%同驾龄司机"),
                      trailing: Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("保持车辆安全距离 评分 97.36 分"),
                      subtitle: Text("超过87.69%同驾龄司机"),
                      trailing: Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("礼让行人 评分 93.36 分"),
                      subtitle: Text("超过91.69%同驾龄司机"),
                      trailing: Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("驾驶路段 超速次数 共 13 次"),
                      subtitle: Text("超过52.69%同驾龄司机"),
                      trailing: Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                onTap: () {
                  _flip(true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '点击我查看详情',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Card(
      color: Colors.grey.shade50,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: '经大数据生成的驾驶报告   ', style: TextStyle(fontSize: 17, color: Colors.black)),
                TextSpan(
                    text: '仅供参考', style: TextStyle(fontSize: 10, color: Colors.teal.shade800)),
              ], style: TextStyle(fontSize: 15, color: Colors.black87,)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, bottom: 24),
            color: Colors.white,
            child: TextFormField(
              enabled: false,
              initialValue: "根据设备检测的健康数据显示，您当前体温为39.3℃，当前体重为64.7kg，当前心率为73次/分，当前血压为121/79每毫米汞柱，当前血脂为4.9mmol/L，综合健康指数分值为88分，需要注意的是您的血脂在正常范围内偏高，平时请注意饮食锻炼。存在健康隐患，详情请至咨询模块询问，或前往医院咨询。",
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              cursorColor: Colors.black38,
              maxLines: 17,
              autofocus: false,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 6),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('返回', textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    _flip(false);
                  },
                ),
              ),
              Container(
                width: 1,
                height: 46,
                color: Colors.grey.withOpacity(0.4),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('分享', textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    shareNotice();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future shareNotice() async {
    await Share.share("生成报告");
  }
}
