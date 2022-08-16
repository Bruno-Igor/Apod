import 'package:api_nasa/src/models/content_model.dart';
import 'package:flutter/material.dart';

import '../../../core/app_constants.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key? key,
    required this.currentContent,
    required this.screenSize,
  }) : super(key: key);

  final ContentModel currentContent;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppConstants.detailsPage,
          arguments: currentContent,
        );
      },
      child: Card(
        color: Colors.grey,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('${currentContent.title}'),
              Text('${currentContent.date}'),
              const SizedBox(height: 10),
              Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                height: screenSize.height * 0.25,
                width: screenSize.width * 0.7,
                child: (currentContent.thumbnailUrl == null &&
                        currentContent.mediaType == 'video')
                    ? const Text('image not found')
                    : Image.network(
                        currentContent.mediaType == 'image'
                            ? currentContent.url!
                            : currentContent.thumbnailUrl!,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
