import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/upload_story_provider.dart';

class UploadStoryScreen extends StatefulWidget {
  final Function() onUploadComplete;
  const UploadStoryScreen({super.key, required this.onUploadComplete});

  @override
  State<UploadStoryScreen> createState() => _UploadStoryScreenState();
}

class _UploadStoryScreenState extends State<UploadStoryScreen> {
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.uploadScreenTitle),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              context.watch<UploadStoryProvider>().imagePath == null
                  ? Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/image-gallery.png",
                        height: 300,
                        width: 300,
                      ),
                    )
                  : _showImage(),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      _onGalleryView();
                    },
                    child: Text(AppLocalizations.of(context)!.uploadGallery),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      _onCameraView();
                    },
                    child: Text(AppLocalizations.of(context)!.uploadCamera),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.uploadDescription,
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                onPressed: () {
                  _onUpload();
                },
                child: context.watch<UploadStoryProvider>().isUploading
                    ? const CircularProgressIndicator(color: primaryColor)
                    : Text(AppLocalizations.of(context)!.uploadButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<UploadStoryProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<UploadStoryProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<UploadStoryProvider>();
    final authProvider = context.read<AuthProvider>();
    final imagePath = provider.imagePath;
    final imageFile = provider.imageFile;
    if (imagePath == null || imageFile == null) return;

    final description = descriptionController.text;
    if (description.isEmpty) {
      scaffoldMessengerState.showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.errorUploadDescriptionMessage),
        ),
      );
      return;
    }
    provider.setUploading(true);
    final token = authProvider.token;
    if (token == null) return;
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();
    final newBytes = await compute(compressImage, bytes);

    await provider.addStory(
      newBytes,
      fileName,
      description,
      token,
    );

    if (provider.addStoryResponse != null) {
      provider.setImageFile(null);
      provider.setImagePath(null);
      descriptionController.clear();
      widget.onUploadComplete();
    }

    provider.setUploading(false);
    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(localizations.successUploadStoryMessage)),
    );
  }

  Widget _showImage() {
    final imagePath = context.read<UploadStoryProvider>().imagePath;

    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            height: 400,
            width: double.infinity,
            fit: BoxFit.contain,
          )
        : Image.file(
            File(
              imagePath.toString(),
            ),
            height: 400,
            width: double.infinity,
            fit: BoxFit.contain,
          );
  }
}
