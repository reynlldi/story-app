import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/get_all_story_provider.dart';
import 'package:story_app/provider/localizations_provider.dart';
import 'package:story_app/provider/upload_story_provider.dart';
import 'package:story_app/routes/my_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRoutes myRoutes;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(
      apiService: ApiService(),
      authRepository: authRepository,
    );
    authProvider.loadToken();
    myRoutes = MyRoutes(authRepository, authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider, GetAllStoryProvider>(
          create: (context) => GetAllStoryProvider(
            apiService: ApiService(),
            token: "",
          ),
          update: (context, authProvider, getAllStoryProvider) {
            getAllStoryProvider?.update(authProvider.token ?? "");
            return getAllStoryProvider!;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => UploadStoryProvider(
            ApiService(),
          ),
        ),
        ChangeNotifierProvider<LocalizationProvider>(
          create: (context) => LocalizationProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocalizationProvider>(context);
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: Colors.black,
                    secondary: secondaryColor),
                textTheme: myTextTheme,
                appBarTheme: const AppBarTheme(elevation: 0),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: provider.locale,
              home: Router(
                routerDelegate: myRoutes,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            );
          },
        )
      ],
    );
  }
}
