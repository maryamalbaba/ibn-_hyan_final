import 'package:flutter/cupertino.dart';

class MyRouteObserver extends NavigatorObserver {
  final ValueNotifier<String> currentRoute = ValueNotifier<String>("/");



  @override
  void didPush(Route route, Route? previousRoute) {
    // super.didPush(route, previousRoute);
    print("push");
    print(route);
    print(previousRoute);
    currentRoute.value = route.settings.name ?? "";
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // super.didPop(route, previousRoute);
    print("pop");
    print(route);
    print(previousRoute);
    currentRoute.value = previousRoute?.settings.name ??"";
  }
}
