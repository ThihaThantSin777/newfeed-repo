import 'package:flutter/foundation.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';

import '../data/apply/news_feed_apply.dart';
import '../data/apply/news_feed_apply_impl.dart';

class DetailsBloc extends ChangeNotifier{

  ///State variable
  bool _dispose = false;
  bool _loading=false;
  NewsFeedVO ? _newsFeedVO;

  ///Getter
  bool get isDispose => _dispose;
  bool get isLoading=>_loading;
  NewsFeedVO? get getNewsFeedVO=>_newsFeedVO;

  ///State Instance
  final NewsFeedApply _newsFeedApply = NewsFeedApplyImpl();

  Future deletePost(int postID){
    return _newsFeedApply.deletePost(postID);
  }
  DetailsBloc(int postID){
    _loading=true;
    _newsFeedApply.getNewsFeedByPostID(postID).then((value) {
      _newsFeedVO=value;
      notifyListeners();
    }).whenComplete(() {
      _loading=false;
      notifyListeners();
    });
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

