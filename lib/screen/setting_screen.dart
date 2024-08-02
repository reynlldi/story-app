import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/widget/flag_icon_widget.dart';

class SettingScreen extends StatelessWidget {
  final Function() onLogout;

  const SettingScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingScreenTitle),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.changeLanguage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const FlagIconWidget(),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final authRead = context.read<AuthProvider>();
                  final result = await authRead.logout();
                  if (result) onLogout();
                },
                child: Text(
                  AppLocalizations.of(context)!.settingLogoutButton,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (authWatch.isLoadingLogout)
            const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
