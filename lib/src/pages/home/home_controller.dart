import 'package:api_nasa/src/models/content_model.dart';
import 'package:api_nasa/src/services/network/network_exception.dart';
import 'package:api_nasa/src/services/network/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  var _contentList = <ContentModel>[];
  List<ContentModel> get contentList => List.from(_contentList);

  var _itemsPerPage = 10;

  int get itemsPerPage => _itemsPerPage;

  void setItemsPerPage(int newItemsPerPage) {
    _itemsPerPage = newItemsPerPage;
    notifyListeners();
  }

  final service = NetworkService();

  bool _loading = false;

  bool get loading => _loading;

  void switchLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchContents([int? imagesQuantity]) async {
    switchLoading(true);
    try {
      var response = await service.fetchData(imagesQuantity: imagesQuantity);
      _contentList =
          (response.data as List).map((e) => ContentModel.fromMap(e)).toList();
    } on NetworkException {
      _contentList = [];
      switchLoading(false);
      rethrow;
    }
    switchLoading(false);
  }
}
