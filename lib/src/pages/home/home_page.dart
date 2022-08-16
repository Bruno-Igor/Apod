import 'package:api_nasa/src/core/app_constants.dart';
import 'package:api_nasa/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'components/content_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late final HomeController homeController;

  @override
  void initState() {
    homeController = HomeController();
    fetch();
    homeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<void> fetch() async {
    if (homeController.loading) return;
    await homeController.fetchContents(homeController.itemsPerPage).catchError(
          (error) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('An error has occurred'),
                content: Text('${error.message}'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: const Text('Ok...'))
                ],
              );
            },
          ),
        );
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa Apod API'),
        actions: [
          DropdownButton<int>(
            value: homeController.itemsPerPage,
            items: List.generate(
              20,
              (index) => DropdownMenuItem(
                value: index + 1,
                child: Text('${index + 1}'),
              ),
            ),
            onChanged: (value) {
              homeController.setItemsPerPage(value!);
              fetch();
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppConstants.configPage);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: homeController,
        builder: (context, child) {
          if (homeController.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (homeController.contentList.isEmpty) {
            return const Center(child: Text('Pull to refresh and get images!'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              fetch();
            },
            child: ListView.builder(
              itemCount: homeController.contentList.length,
              itemBuilder: (context, index) {
                var currentContent = homeController.contentList[index];
                return ContentCard(
                  currentContent: currentContent,
                  screenSize: screenSize,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetch(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
