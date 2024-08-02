import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/data/model/detail_story_model.dart';
import 'package:story_app/provider/localizations_provider.dart';
import 'package:story_app/utils/convert_date.dart';

class DetailStoryWidget extends StatelessWidget {
  final Story detailStory;

  const DetailStoryWidget({super.key, required this.detailStory});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = context.watch<LocalizationProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/blocks.gif",
            image: detailStory.photoUrl,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/image_error.png');
            },
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.detailPostedBy,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                detailStory.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.detailDescription,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                detailStory.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.detailPostedOn,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                convertDateTime(detailStory.createdAt.toString(),
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
    );
  }
}
