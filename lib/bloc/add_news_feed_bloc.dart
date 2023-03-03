import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:simple_news_feed_app/data/apply/news_feed_apply_impl.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/enums.dart';

import '../data/apply/news_feed_apply.dart';

class AddNewsFeedBloc extends ChangeNotifier {
  ///State Variable
  bool _dispose = false;
  bool _post = false;
  File? _selectFile;
  String _description = '';
  NewsFeedVO? _newsFeedVO;

  ///Getter
  bool get isDispose => _dispose;


  bool get canPost => _post;

  File? get getSelectFile => _selectFile;

  NewsFeedVO? get getNewsFeedVO => _newsFeedVO;

  ///State Instance
  final NewsFeedApply _newsFeedApply = NewsFeedApplyImpl();

  Future onTapPost() {
    if(_newsFeedVO!=null){
      _newsFeedVO?.description=_description;
    }
    return _newsFeedApply.createPost(_description, _newsFeedVO);
  }

  AddNewsFeedBloc( int postID) {
    if ( postID != -1) {

      _newsFeedApply.getNewsFeedByPostID(postID).then((value) {
        _newsFeedVO = value;
        notifyListeners();
      });
    }
  }

  void setSelectFileNull() {
    _selectFile = null;
    // _post=false;
    notifyListeners();
  }

  void setSelectFile(File? file) {
    if (file != null) {
      _selectFile = file;
      // _post=true;
      notifyListeners();
    }
  }

  void setCanPostStatus(String text) {
    if (text.isNotEmpty) {
      _post = true;
    } else {
      _post = false;
    }
    _description = text;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}
