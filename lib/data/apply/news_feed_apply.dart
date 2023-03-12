import 'dart:io';

import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';

abstract class NewsFeedApply{
  Stream<List<NewsFeedVO>?>getNewsFeedList();

  Future<void> createPost(String description,NewsFeedVO ? newsFeedVO,File ?file);

  Future<void> deletePost(int postID);

  Future<NewsFeedVO>getNewsFeedByPostID(int postID);
}