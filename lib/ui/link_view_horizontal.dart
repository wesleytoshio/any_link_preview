import 'package:flutter/material.dart';

class LinkViewHorizontal extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final String imageUri;
  final Function(String) onTap;
  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;
  final bool showMultiMedia;
  final TextOverflow bodyTextOverflow;
  final int bodyMaxLines;
  final int titleMaxLines;
  final bool isIcon;
  final double radius;
  final Color bgColor;

  LinkViewHorizontal({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    @required this.onTap,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.titleMaxLines,
    this.isIcon = false,
    this.bgColor,
    this.radius,
  })  : assert(imageUri != null),
        assert(title != null),
        assert(url != null),
        assert(description != null),
        assert(onTap != null),
        super(key: key);

  double computeTitleFontSize(double width) {
    double size = width * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight) {
    return layoutHeight >= 100 ? 2 : 1;
  }

  int computeBodyLines(layoutHeight) {
    var lines = 1;
    if (layoutHeight > 40) {
      lines += (layoutHeight - 40.0) ~/ 15.0;
    }
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var layoutWidth = constraints.biggest.width;
        var layoutHeight = constraints.biggest.height;

        var _titleFontSize = titleTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
        var _bodyFontSize = bodyTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth) - 1,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            );

        return InkWell(
          onTap: () => onTap(url),
          child: Row(
            children: <Widget>[
              showMultiMedia
                  ? Expanded(
                      flex: 2,
                      child: imageUri == ""
                          ? Container(color: bgColor ?? Colors.grey)
                          : Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUri),
                                  fit: isIcon ? BoxFit.contain : BoxFit.cover,
                                ),
                                borderRadius: radius == 0
                                    ? BorderRadius.zero
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(radius),
                                        bottomLeft: Radius.circular(radius),
                                      ),
                              ),
                            ),
                    )
                  : SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTitleContainer(
                          _titleFontSize, computeTitleLines(layoutHeight)),
                      _buildBodyContainer(
                          _bodyFontSize, computeBodyLines(layoutHeight))
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleContainer(TextStyle _titleTS, _maxLines) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1.0, -1.0),
          child: Text(
            title,
            style: _titleTS,
            overflow: TextOverflow.ellipsis,
            maxLines: bodyMaxLines == null ? _maxLines : bodyMaxLines,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyContainer(TextStyle _bodyTS, _maxLines) {
    return Expanded(
      flex: 2,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment(-1.0, -1.0),
              child: Text(
                description,
                textAlign: TextAlign.left,
                style: _bodyTS,
                overflow: bodyTextOverflow == null
                    ? TextOverflow.ellipsis
                    : bodyTextOverflow,
                maxLines: bodyMaxLines == null ? _maxLines : bodyMaxLines,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
