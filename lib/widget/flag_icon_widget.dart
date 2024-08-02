import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/provider/localizations_provider.dart';
import 'package:story_app/utils/localization_switch_language.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = context.watch<LocalizationProvider>();

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        icon: const Icon(Icons.arrow_forward_ios),
        value: localizationProvider.locale,
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = LocalizationSwitchLanguage.getFlag(locale.languageCode);
          return DropdownMenuItem<Locale>(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            onTap: () {
              final provider =
                  Provider.of<LocalizationProvider>(context, listen: false);
              provider.setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
