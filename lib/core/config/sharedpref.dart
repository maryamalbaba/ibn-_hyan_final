import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;
Setup() async {

  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

getoptions() {
  
  {
    headers:
    {}
  }
}
