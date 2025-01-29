import 'package:flutter/material.dart';

// 자주 사용 하는 context 관련 기능을 확장
extension ContextExtensions on BuildContext {
  // 페이지 이동
  void navigateTo(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  // 이전 페이지 삭제 후 이동
  void navigateToAndRemove(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  // 사이즈
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;
}
