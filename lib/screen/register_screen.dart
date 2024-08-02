import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureTextPassword = true;

  void passwordVisibility() {
    setState(() {
      obscureTextPassword = !obscureTextPassword;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.registerTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppLocalizations.of(context)!.registerSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.nameTitleForm,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.erorEnterName;
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.nameHintForm,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.emailTitleForm,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.erorEnterEmail;
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.emailHintForm,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.passwordTitleForm,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscureTextPassword,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.passwordHintForm,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureTextPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: passwordVisibility,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.erorEnterPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  context.watch<AuthProvider>().isLoadingRegister
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final localizations =
                                  AppLocalizations.of(context)!;
                              final name = nameController.text;
                              final email = emailController.text;
                              final password = passwordController.text;
                              final authRead = context.read<AuthProvider>();
                              final success = await authRead.register(
                                  name, email, password);
                              if (success) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(localizations.successRegister),
                                  ),
                                );
                                widget.onLogin();
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(localizations
                                        .errorButtonRegisterMessage),
                                  ),
                                );
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.registerButton,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: primaryColor),
                          ),
                        ),
                  const SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.haveTitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.haveButton,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.onLogin();
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
