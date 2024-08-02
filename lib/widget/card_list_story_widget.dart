import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/get_all_story_model.dart';
import 'package:story_app/provider/localizations_provider.dart';
import 'package:story_app/utils/convert_date.dart';

class CardListStoryWidget extends StatelessWidget {
  final ListStory listStory;
  final Function(String) onTapped;

  const CardListStoryWidget({
    super.key,
    required this.listStory,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    final localizationProvider = context.watch<LocalizationProvider>();

    return GestureDetector(
      onTap: () => onTapped(listStory.id),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/blocks.gif",
              image: listStory.photoUrl,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/image_error.png');
              },
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    listStory.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    listStory.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    convertDateTime(listStory.createdAt.toString(),
                        localizationProvider.locale),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
