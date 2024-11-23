import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }

  Widget visible(bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: this,
    );
  }
}
