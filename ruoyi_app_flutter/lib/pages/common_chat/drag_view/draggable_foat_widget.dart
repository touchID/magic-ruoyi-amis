import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DraggableFloatWidget extends StatefulWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Widget child;
  final double bottomMargin;
  final double topMargin;
  final double horizontalSpace;
  final double verticalSpace;
  final GlobalKey? containerKey;
  final DraggableFloatController? controller;

  const DraggableFloatWidget({
    super.key,
    required this.child,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.bottomMargin = 0,
    this.topMargin = 0,
    this.horizontalSpace = 10,
    this.verticalSpace = 10,
    this.containerKey,
    this.controller,
  });

  @override
  State<DraggableFloatWidget> createState() => _DraggableFloatWidgetState();
}

class _DraggableFloatWidgetState extends State<DraggableFloatWidget> {
  final GlobalKey _floatKey = GlobalKey();

  double _top = 0;
  double _left = 0;
  double _width = 0;
  double _height = 0;

  double _dragStartX = 0;
  double _dragStartY = 0;
  double _dragStartTop = 0;
  double _dragStartLeft = 0;

  late DraggableFloatController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DraggableFloatController();
    _controller._state = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initPosition();
  }

  void _initPosition() {
    if (widget.top != null || widget.left != null) {
      _top = widget.top ?? 0;
      _left = widget.left ?? 0;
    } else {
      _top = MediaQuery.of(context).size.height - 200;
      _left = MediaQuery.of(context).size.width - 80;
    }
    setState(() {});
  }

  void _onPanDown(DragDownDetails details) {
    _dragStartX = details.globalPosition.dx;
    _dragStartY = details.globalPosition.dy;
    _dragStartTop = _top;
    _dragStartLeft = _left;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double newLeft = _dragStartLeft + (details.globalPosition.dx - _dragStartX);
    double newTop = _dragStartTop + (details.globalPosition.dy - _dragStartY);

    double maxWidth = (widget.containerKey?.currentContext?.size?.width ?? MediaQuery.of(context).size.width) - _width - widget.horizontalSpace;
    double maxHeight = (widget.containerKey?.currentContext?.size?.height ?? MediaQuery.of(context).size.height) - _height - widget.bottomMargin;

    newLeft = newLeft.clamp(widget.horizontalSpace, maxWidth);
    newTop = newTop.clamp(widget.topMargin, maxHeight);

    setState(() {
      _left = newLeft;
      _top = newTop;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    double screenWidth = widget.containerKey?.currentContext?.size?.width ?? MediaQuery.of(context).size.width;
    double targetLeft = _left > screenWidth / 2 ? screenWidth - _width - widget.horizontalSpace : widget.horizontalSpace;

    setState(() {
      _left = targetLeft;
    });
  }

  void updatePosition(double top, double left) {
    setState(() {
      _top = top;
      _left = left;
    });
  }

  void show() {
    setState(() {});
  }

  void hide() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: GestureDetector(
        key: _floatKey,
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: widget.child,
      ),
    );
  }
}

class DraggableFloatController {
  _DraggableFloatWidgetState? _state;

  void updatePosition(double top, double left) {
    _state?.updatePosition(top, left);
  }

  void show() {
    _state?.show();
  }

  void hide() {
    _state?.hide();
  }
}
