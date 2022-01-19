import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectableCell {
  final bool isSelected;
  const SelectableCell({required this.isSelected});
}

enum GridDisplayMode { twoColumns, threeColumns }

extension GridDisplayModeExt on GridDisplayMode {
  int get crossAxisCount {
    switch (this) {
      case GridDisplayMode.twoColumns:
        return 2;
      case GridDisplayMode.threeColumns:
        return 3;
    }
  }

  double get cellSize {
    switch (this) {
      case GridDisplayMode.twoColumns:
        return 45.w;
      case GridDisplayMode.threeColumns:
        return 30.w;
    }
  }
}

typedef WidgetRenderDelegate<IncomeModel, RenderOptions> = Widget Function(
    IncomeModel model, RenderOptions renderOptions);

class SelectableGridCell extends StatelessWidget {
  final double size;
  final double? scaleHeightFor;
  final Positioned? _activityStatusIndicatorWidget;
  final Widget _childWidget;
  final Widget? bottomWidget;
  const SelectableGridCell(
      {Key? key,
        required this.size,
        this.scaleHeightFor,
        required Widget childWidget,
        this.bottomWidget,
        Positioned? activityStatusIndicatorWidget})
      : _childWidget = childWidget,
        _activityStatusIndicatorWidget = activityStatusIndicatorWidget,
        super(key: key);

  get _height => scaleHeightFor != null
      ? (size + (size * scaleHeightFor!))
      : size;

  get _optionalBottomMargin =>
      bottomWidget != null ? _height * ((_height - size) / _height) : 0.0;

  get _startBottomChildWidget => _optionalBottomMargin * 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: _height + _optionalBottomMargin,
      width: size,
      child: Stack(
        children: [
          Positioned(
            bottom: _startBottomChildWidget,
            left: 0,
            right: 0,
            top: 0,
            child: _childWidget,
          ),
          if (bottomWidget != null)
            Positioned(
                child: bottomWidget!,
                left: 0,
                right: 0,
                bottom: 0,
                top: _height - _optionalBottomMargin),
          if (_activityStatusIndicatorWidget != null)
            _activityStatusIndicatorWidget!,
        ],
      ),
    );
  }
}

class FollowersSelectableGridCell extends SelectableGridCell{
  const FollowersSelectableGridCell({Key? key,
    required double size,
    double? scaleHeightFor,
    Positioned? activityStatusIndicatorWidget,
    required Widget childWidget,
    Widget? bottomWidget}) :
        super(key: key, size: size, scaleHeightFor: scaleHeightFor,
          activityStatusIndicatorWidget: activityStatusIndicatorWidget, childWidget: childWidget,
          bottomWidget: bottomWidget);

  @override
  get _startBottomChildWidget => _optionalBottomMargin;
}
