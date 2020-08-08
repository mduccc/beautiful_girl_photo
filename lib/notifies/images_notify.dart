import 'dart:convert';

import 'package:beautiful_girl_photo/models/image_model.dart';
import 'package:beautiful_girl_photo/repositories/images_repository.dart';
import 'package:beautiful_girl_photo/utils/permission.dart';
import 'package:flutter/material.dart';

class ImagesNotify extends ChangeNotifier {
  final ImagesRepository _repository;
  final List<ImageModel> imgs = [];
  final String _tabID;
  int _page = 0;

  ImagesNotify(this._repository, [this._tabID = '']);

  void fetch() {
    _page = 0;
    _repository.fetch(_tabID, page: _page).then((value) {
      jsonEncode(value.map((e) => e.toJson()).toList());
      imgs
        ..clear()
        ..addAll(value);
      notifyListeners();
    });
  }

  void save(ImageModel img) {
    CheckPermission.hasWriteStoragePermission().then((status) {
      _repository
          .save(img.urlFullSize.isEmpty ? img.thumbnail : img.urlFullSize)
          .then((_) {
        // TODO: success save image
      });
    });
  }

  void updateHeart(ImageModel img) {
    _repository.updateHeart(img).then((_) {
      // TODO: success update heart
    });
  }

  void loadMore() {
    _repository.fetch(_tabID, page: ++_page).then((value) {
      imgs.addAll(value);
      notifyListeners();
    });
  }
}
