import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/network/data_agent/news_feed_data_agent.dart';

import '../../constant/strings.dart';

class CloudFireStoreDataAgentImpl extends NewsFeedDataAgent {
  CloudFireStoreDataAgentImpl._();

  static final CloudFireStoreDataAgentImpl _singleton =
      CloudFireStoreDataAgentImpl._();

  factory CloudFireStoreDataAgentImpl() => _singleton;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Future<void> createPost(NewsFeedVO newsFeedVO) => _firebaseFireStore
      .collection(kRootNodeForNewFeed)
      .doc(newsFeedVO.id.toString())
      .set(newsFeedVO.toJson());

  @override
  Future<void> deletePost(int postID) => _firebaseFireStore
      .collection(kRootNodeForNewFeed)
      .doc(postID.toString())
      .delete();

  @override
  Stream<List<NewsFeedVO>?> getNewFeedList() => _firebaseFireStore
          .collection(kRootNodeForNewFeed)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map((document) {
          return NewsFeedVO.fromJson(document.data());
        }).toList();
      });

  @override
  Future<NewsFeedVO> getNewsFeedByPostID(int postID) => _firebaseFireStore
      .collection(kRootNodeForNewFeed)
      .doc(postID.toString())
      .get()
      .asStream()
      .map((documentSnapShot) =>
          NewsFeedVO.fromJson(documentSnapShot?.data() ?? {}))
      .first;
}
