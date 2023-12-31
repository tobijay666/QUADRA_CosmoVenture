import 'package:cosmoventure/presentaion/pages/booking.dart';
import 'package:cosmoventure/presentaion/pages/chat.dart';
import 'package:cosmoventure/presentaion/pages/discover.dart';
import 'package:cosmoventure/presentaion/pages/home.dart';
import 'package:cosmoventure/presentaion/pages/profile.dart';
import 'package:cosmoventure/presentaion/pages/search.dart';
import 'package:cosmoventure/presentaion/pages/settings.dart';
import 'package:cosmoventure/presentaion/pages/splash.dart';
import 'package:cosmoventure/presentaion/pages/user_Chat.dart';
import 'package:cosmoventure/presentaion/widgets/user.dart';
import 'package:cosmoventure/utils/app_colors.dart';
import 'package:cosmoventure/utils/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'dependency_injection.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            displayLarge: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            displayMedium: GoogleFonts.roboto(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
            displaySmall: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            headlineMedium: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            headlineSmall: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            labelLarge: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        home: SplashScreen());
  }
}

class MyHomePage extends StatefulWidget {
  late int index;
  final String uid;
  MyHomePage({Key? key, required this.index, required this.uid})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      ChatScreen(uid: widget.uid),
      SearchScreen(uid: widget.uid),
      HomeScreen(uid: widget.uid),
      DiscoverScreen(uid: widget.uid),
      SettingScreen(uid: widget.uid),
      BookingsScreen(uid: widget.uid),
    ];
  }

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[widget.index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.black)),
        child: CurvedNavigationBar(
          key: navigationKey,
          animationDuration: const Duration(milliseconds: 300),
          height: 60,
          color: AppColors.whiteColor,
          backgroundColor: AppColors.black2,
          buttonBackgroundColor: AppColors.outlineColor,
          items: const <Widget>[
            Icon(Icons.message, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.explore, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          index: widget.index,
          onTap: (index) {
            setState(() {
              widget.index = index;
            });
            //Handle button tap
          },
        ),
      ),
    );
  }
}
