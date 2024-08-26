import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/data/model/request/detail_story_request.dart';
import 'package:story_app/provider/localizations_provider.dart';
import 'package:story_app/utils/convert_date.dart';

class DetailStoryWidget extends StatefulWidget {
  final DetailStory detailStory;

  const DetailStoryWidget({super.key, required this.detailStory});

  @override
  State<DetailStoryWidget> createState() => _DetailStoryWidgetState();
}

class _DetailStoryWidgetState extends State<DetailStoryWidget> {
  String? address;

  @override
  void initState() {
    super.initState();
    if (widget.detailStory.lat != null && widget.detailStory.lon != null) {
      _getAddress();
    }
  }

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
            image: widget.detailStory.photoUrl,
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
                widget.detailStory.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.detailDescription,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                widget.detailStory.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.detailPostedOn,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                convertDateTime(widget.detailStory.createdAt.toString(),
                    localizationProvider.locale),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.grey[500]),
              ),
              const SizedBox(height: 20),
              if (widget.detailStory.lat != null &&
                  widget.detailStory.lon != null) ...[
                Text(
                  "Detail Location",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          widget.detailStory.lat!, widget.detailStory.lon!),
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(widget.detailStory.id),
                        position: LatLng(
                            widget.detailStory.lat!, widget.detailStory.lon!),
                      )
                    },
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                ),
                if (address != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    "Detail Location",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    address!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ] else
                Text(
                  "Nothing Detail Location ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.detailStory.lat!,
        widget.detailStory.lon!,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          address =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
