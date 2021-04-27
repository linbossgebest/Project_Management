import 'package:flutter/material.dart';

//FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
class FadeRoute extends PageRouteBuilder {
    final Widget page;
    FadeRoute({this.page}): super(
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
        ) =>page,transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
        ) =>FadeTransition(
            opacity: animation,
            child: child,
        ),
    );
}