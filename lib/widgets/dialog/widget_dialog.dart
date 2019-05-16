import 'package:flutter/material.dart';
import 'package:aided_driving_app/utils/tts/tts_helper.dart';

class WidgetDialog extends StatelessWidget {
  final Widget widget;
  final Text title;
  final Text description;
  final bool onlyOkButton;
  final Text buttonOkText;
  final Text buttonCancelText;
  final Color buttonOkColor;
  final Color buttonCancelColor;
  final double buttonRadius;
  final double cornerRadius;
  final VoidCallback onOkButtonPressed;

  WidgetDialog({
    Key key,
    @required this.widget,
    @required this.onOkButtonPressed,
    this.title,
    this.description,
    this.onlyOkButton = false,
    this.buttonOkText,
    this.buttonCancelText,
    this.buttonOkColor,
    this.buttonCancelColor,
    this.cornerRadius = 8.0,
    this.buttonRadius = 8.0,
  })  : assert(widget != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Card(
                color: Colors.white,
                elevation: 0.0,
                margin: EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(cornerRadius),
                        topLeft: Radius.circular(cornerRadius))),
                clipBehavior: Clip.antiAlias,
                child: widget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: !onlyOkButton
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: <Widget>[
                  !onlyOkButton
                      ? RaisedButton(
                    color: buttonCancelColor ?? Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(buttonRadius)),
                    onPressed: () => Navigator.of(context).pop(),
                    child: buttonCancelText ??
                        Text(
                          '关闭',
                          style: TextStyle(color: Colors.white),
                        ),
                  )
                      : Container(),
                  RaisedButton(
                    color: buttonOkColor ?? Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonRadius)),
                    onPressed: onOkButtonPressed ?? () {},
                    child: buttonOkText ??
                        Text(
                          '播报',
                          style: TextStyle(color: Colors.white),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
