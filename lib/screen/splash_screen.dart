import 'package:flutter/material.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/splash_image.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.splashTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: primaryColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
