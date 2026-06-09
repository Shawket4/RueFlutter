import 'package:flutter/widgets.dart';

enum FormFactor { phone, tablet, desktop }

extension ResponsiveX on BuildContext {
  FormFactor get formFactor {
    final shortestSide = MediaQuery.of(this).size.shortestSide;
    final longestSide = MediaQuery.of(this).size.longestSide;
    
    if (longestSide >= 1100) return FormFactor.desktop;
    if (shortestSide >= 600) return FormFactor.tablet;
    return FormFactor.phone;
  }

  bool get isPhone => formFactor == FormFactor.phone;
  bool get isTablet => formFactor == FormFactor.tablet;
  bool get isDesktop => formFactor == FormFactor.desktop;

  double responsive({
    required double phone,
    double? tablet,
    double? desktop,
  }) {
    switch (formFactor) {
      case FormFactor.desktop:
        return desktop ?? tablet ?? phone;
      case FormFactor.tablet:
        return tablet ?? phone;
      case FormFactor.phone:
        return phone;
    }
  }
}
