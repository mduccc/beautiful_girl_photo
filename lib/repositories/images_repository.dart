import 'dart:convert';
import 'dart:io';

import 'package:beautiful_girl_photo/mocks/mock_data.dart';
import 'package:beautiful_girl_photo/models/image_model.dart';
import 'package:beautiful_girl_photo/models/tab_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

abstract class ImagesRepository {
  Future<List<TabModel>> fetchTab();

  Future<List<ImageModel>> fetch(String tabID, {int page});

  Future<Either<Exception, bool>> save(String url);

  Future updateHeart(ImageModel img);
}

class FetchImagesRepositoryImpl implements ImagesRepository {
  @override
  Future<List<TabModel>> fetchTab() async => [
        TabModel(tabID: 'unisex', tabName: 'Unisex'),
        TabModel(tabID: 'korea', tabName: 'Korea')
      ];

  @override
  Future<List<ImageModel>> fetch(String tabID, {int page = 0}) async =>
      tabID == 'unisex'
          ? (jsonDecode(mockUnisexJson) as List)
              .map((ele) => ImageModel.fromJson(ele))
              .toList()
          : (jsonDecode(mockKoreaJson) as List)
              .map((ele) => ImageModel.fromJson(ele))
              .toList();

  @override
  Future<Either<Exception, bool>> save(String url,
      {bool isAndroid = true}) async {
    try {
      if (isAndroid) {
        Directory dir = await getExternalStorageDirectory();
        String path = '${dir.parent.parent.parent.parent.path}/Ulzzang';
        if (!Directory(path).existsSync()) {
          Directory(path).createSync();
        }
        await FlutterDownloader.enqueue(
          url: url,
          savedDir: path,
          showNotification: true,
          // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
        return Right(true);
      } else {
        throw 'Not support os yet';
      }
    } catch (error) {
      return Left(error);
    }
  }

  @override
  Future updateHeart(ImageModel img) {
    // TODO: implement heart
    throw UnimplementedError();
  }
}
