import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/config/sharedpref.dart';
import 'package:ibnhyanfinal/feature/auth/view/firstPage.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await EasyLocalization.ensureInitialized();
  await Setup();
  runApp(EasyLocalization(
      supportedLocales: const [ Locale('ar')],
      path: 'assets/translate', // <-- change the path of the translation files 
      fallbackLocale: Locale('ar',),
      child: const MyApp()
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
    localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
    home:const welcomePage(),
    
  //  welcomePage()
    );
  }
}
