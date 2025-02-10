import 'package:flutter/cupertino.dart';

class MyRouteObserver extends NavigatorObserver {
  final ValueNotifier<String> currentRoute = ValueNotifier<String>("/");



  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    currentRoute.value = newRoute?.settings.name ?? "";
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    currentRoute.value = route.settings.name ?? "";
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    currentRoute.value = previousRoute?.settings.name ??"";
  }
}
