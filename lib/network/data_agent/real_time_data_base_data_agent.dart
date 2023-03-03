import 'package:firebase_database/firebase_database.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/network/data_agent/news_feed_data_agent.dart';

class RealTimeDataBaseDataAgent extends NewsFeedDataAgent {
  RealTimeDataBaseDataAgent._();

  static final RealTimeDataBaseDataAgent _singleton =
      RealTimeDataBaseDataAgent._();

  factory RealTimeDataBaseDataAgent() => _singleton;

  final database = FirebaseDatabase.instance.ref();

  @override
  Stream<List<NewsFeedVO>?> getNewFeedList() {
    return database.child(kRootNodeForNewFeed).onValue.map((event) {
      return event.snapshot.children.map<NewsFeedVO>((snapshot) {
        return NewsFeedVO.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Future<void> createPost(NewsFeedVO newsFeedVO) {
    return database
        .child(kRootNodeForNewFeed)
        .child(newsFeedVO.id.toString() ??
            DateTime.now().microsecondsSinceEpoch.toString())
        .set(newsFeedVO.toJson());
  }

  @override
  Future<void> deletePost(int postID) {
    return database
        .child(kRootNodeForNewFeed)
        .child(postID.toString())
        .remove();
  }

  @override
  Future<NewsFeedVO> getNewsFeedByPostID(int postID) {
    return database
        .child(kRootNodeForNewFeed)
        .child(postID.toString())
        .once()
        .asStream()
        .map((event) => event.snapshot)
        .map((snapshot) {
      return NewsFeedVO.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map));
    }).first;
  }
}
