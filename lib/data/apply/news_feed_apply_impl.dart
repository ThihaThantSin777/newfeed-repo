import 'package:simple_news_feed_app/data/apply/news_feed_apply.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/network/data_agent/news_feed_data_agent.dart';
import 'package:simple_news_feed_app/network/data_agent/real_time_data_base_data_agent.dart';

class NewsFeedApplyImpl extends NewsFeedApply {
  NewsFeedApplyImpl._();

  static final NewsFeedApplyImpl _singleton = NewsFeedApplyImpl._();

  factory NewsFeedApplyImpl() => _singleton;

  final NewsFeedDataAgent _newsFeedDataAgent = RealTimeDataBaseDataAgent();

  @override
  Stream<List<NewsFeedVO>?> getNewsFeedList() =>
      _newsFeedDataAgent.getNewFeedList();

  @override
  Future<void> createPost(String description,NewsFeedVO ? newsFeedVO) {
  if(newsFeedVO==null){
    NewsFeedVO newsFeed = NewsFeedVO(
        DateTime.now().microsecondsSinceEpoch,
        description,
        'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
        'https://i0.wp.com/thegeekiary.com/wp-content/uploads/2017/04/BorutoChapter1.png',
        'Thiha Thant Sin');
    return _newsFeedDataAgent.createPost(newsFeed);
  }

    return _newsFeedDataAgent.createPost(newsFeedVO);
  }

  @override
  Future<void> deletePost(int postID) {
   return _newsFeedDataAgent.deletePost(postID);
  }

  @override
  Future<NewsFeedVO> getNewsFeedByPostID(int postID) =>_newsFeedDataAgent.getNewsFeedByPostID(postID);
}
