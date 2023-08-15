import 'package:cosmoventure/main.dart';
import 'package:cosmoventure/presentaion/pages/login.dart';
import 'package:cosmoventure/utils/app_images.dart';
import 'package:cosmoventure/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return _bodyWidget();
  }

  _bodyWidget() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Image(image: AssetImage(AppImages.splashImage)),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.splashTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: AppColors.whiteColor,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.splashTitle2,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.lightGrayColor,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),
                      child: SwipeTo(
                        iconOnRightSwipe: Icons.arrow_forward,
                        iconColor: Colors.grey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: Center(
                              child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      8), // Adjust the radius as needed
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Swap to Start Journey',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                              ),
                            ],
                          )),
                        ),
                        onRightSwipe: () {
                          print('Callback from Swipe To Right');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen()), // Replace NewPage with the actual new page you want to navigate to
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          AppStrings.poweredBy,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
