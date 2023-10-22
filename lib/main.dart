import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:procodder/controllers/ChatContoller.dart';
import 'package:procodder/controllers/PostController.dart';
import 'package:procodder/views/Home/homePage.dart';
import 'package:procodder/views/Post/CreatePostScreen.dart';
import 'package:procodder/views/Post/postScreen.dart';
import 'package:procodder/views/profile/ProfileScreen.dart';

import 'Views/signin_signup/login_screen.dart';
import 'config/config.dart';
import 'controllers/AuthController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(PostController());
    Get.put(ChatController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
          debugShowMaterialGrid:false,
        theme: ThemeData(
            primaryColorDark: const Color(0xff1F41BB),
            primaryColor: const Color(0xff1F41BB),
            highlightColor: Colors.white,
            indicatorColor: const Color(0xff788BAB),
            unselectedWidgetColor:const Color(0xff788BAB),
            backgroundColor: const Color(0xfff3f4f6),
            shadowColor:const Color(0xff000000) ,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff1F41BB),
                background: const Color(0xfff3f4f6),
                brightness: Brightness.light),
            fontFamily: GoogleFonts.poppins().fontFamily),
        home: Obx(() => authController.isLoggedIn.isTrue
            ? const MyHomePage()
            : LoginScreen()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _selectedItemPosition = 0;
  // final cont = Get.put(EmployeeContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        color: Theme.of(context).highlightColor,
        duration: const Duration(seconds: 1),
        child: IndexedStack(
          index: _selectedItemPosition,
          children:   <Widget>[
            const postScreen(),
            const CreatePostScreen(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeViewColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).highlightColor,
        selectedItemColor: Theme.of(context).highlightColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(HeroIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.square_plus), label: 'Assistent'),
          BottomNavigationBarItem(icon: Icon(HeroIcons.users), label: 'Setting')
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
