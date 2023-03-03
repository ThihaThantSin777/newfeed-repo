import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/extensions.dart';
import 'package:simple_news_feed_app/view_items/add_post_view_items/add_post_view_items.dart';
import 'package:simple_news_feed_app/widgets/alert_dialog_widget.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';
import 'package:simple_news_feed_app/widgets/image_video_file_view_widget.dart';
import 'package:simple_news_feed_app/widgets/profile_widget.dart';

import '../bloc/add_news_feed_bloc.dart';

class AddNewsFeedPage extends StatelessWidget {
  const AddNewsFeedPage(
      {Key? key,
      required this.profileName,
      required this.profileURL,
      this.postID = -1,})
      : super(key: key);
  final String profileName;
  final String profileURL;
  final int postID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewsFeedBloc( postID),
      child: Scaffold(
          floatingActionButton: Selector<AddNewsFeedBloc, bool>(
              selector: (_, bloc) => bloc.canPost,
              builder: (_, canPost, __) => FloatingActionView(
                    canPost: canPost,
                  )),
          appBar: AppBar(
            title: const EasyText(
              text: kAppTitle,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: kPrimaryBgColor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => context.navigateBack(context),
              icon: const Icon(Icons.navigate_before),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  child: ProfileWidget(
                      profileName: profileName,
                      profileURL: profileURL,
                      subDescription: kSubDescriptionText,
                      trailingWidget: const IconButtonView()),
                ),
                Selector<AddNewsFeedBloc, File?>(
                  selector: (context, bloc) => bloc.getSelectFile,
                  builder: (context, selectFile, _) => (selectFile == null)
                      ? const SizedBox.shrink()
                      : Stack(
                    children: [
                      ImageViewFileViewWidget(
                        onTap: (url) {},
                        isFromNetwork: false,
                        file: '',
                        selectFile: selectFile,
                        type: selectFile.getFileType(),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: RemoveImageItemView(),
                      )
                    ],
                  ),
                ),
                Selector<AddNewsFeedBloc, NewsFeedVO?>(
                    selector: (context, bloc) => bloc.getNewsFeedVO,
                    builder: (context, newsFeed, _) {

                      return  PostTextFiledItemView(
                        newsFeedVO: newsFeed,
                      );

                    })
              ],
            ),
          )
      ),
    );
  }
}
