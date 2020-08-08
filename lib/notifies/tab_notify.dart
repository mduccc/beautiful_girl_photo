import 'package:beautiful_girl_photo/models/tab_model.dart';
import 'package:beautiful_girl_photo/repositories/images_repository.dart';
import 'package:flutter/foundation.dart';

class TabNotify extends ChangeNotifier {
  final ImagesRepository _repository;
  final List<TabModel> tabs = [];

  TabNotify(this._repository);

  void fetch() {
    _repository.fetchTab().then((value) async {
      tabs
        ..clear()
        ..addAll(value);
      notifyListeners();
    });
  }
}
