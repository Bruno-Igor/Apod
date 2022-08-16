import 'package:api_nasa/src/models/content_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentContent =
        ModalRoute.of(context)!.settings.arguments as ContentModel;
    final screenSize = MediaQuery.of(context).size;

    final List apiData = [];
    currentContent.toMap().forEach((key, value) {
      if (value != null) {
        apiData.add(
          Text(
            key,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
        apiData.add(
          const SizedBox(height: 2),
        );
        apiData.add(
          Text(value, style: const TextStyle(fontSize: 16)),
        );
        apiData.add(
          const SizedBox(height: 8),
        );
      }
    });

    final bool dontHaveImage = currentContent.thumbnailUrl == null &&
        currentContent.mediaType == 'video';
    return Scaffold(
      appBar: AppBar(title: Text('${currentContent.title} info\'s')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade600,
                height: dontHaveImage ? screenSize.height * 0.25 : null,
                width: screenSize.width,
                alignment: Alignment.center,
                child: dontHaveImage
                    ? const Text('image not found')
                    : Image.network(
                        currentContent.mediaType == 'image'
                            ? currentContent.url!
                            : currentContent.thumbnailUrl!,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              const SizedBox(height: 10),
              ...apiData,
            ],
          ),
        ),
      ),
    );
  }
}
