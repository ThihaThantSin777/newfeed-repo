
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';

abstract class NewsFeedDataAgent{
  Stream<List<NewsFeedVO>?>getNewFeedList();

  Future<void> createPost(NewsFeedVO newsFeedVO);

  Future<void> deletePost(int postID);

  Future<NewsFeedVO>getNewsFeedByPostID(int postID);
}