import 'package:flutter/material.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/extensions.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';
import 'package:simple_news_feed_app/widgets/image_video_file_view_widget.dart';
import 'package:simple_news_feed_app/widgets/profile_widget.dart';

import '../../pages/add_news_feed_page.dart';

class NewsFeedItemView extends StatelessWidget {
  const NewsFeedItemView({Key? key, required this.newsFeed}) : super(key: key);
  final NewsFeedVO newsFeed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSP10x),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Profile Session
            ProfileWidget(
              profileName: newsFeed.userName ?? '',
              profileURL: newsFeed.profile ?? '',
              subDescription: kSubDescriptionText,
              trailingWidget: PopUpMenuView(
                onSelect: (value) {
                  if (value == kDeleteText) {

                    context
                        .getHomePageBlocInstance()
                        .deletePost(newsFeed.id ?? 0)
                        .then((value) {


                    }).catchError((error) {

                    });
                  }
                  if (value == kEditText) {
                    context.navigateToNextScreen(
                        context,
                        AddNewsFeedPage(
                          profileName:
                              context.getHomePageBlocInstance().getProfileName,
                          profileURL:
                              context.getHomePageBlocInstance().getProfileURL,
                          postID: newsFeed.id ?? 0,
                        ));
                  }
                },
              ),
            ),
            const SizedBox(
              height: kSP5x,
            ),

            /// Description View
            Flexible(
                child:
                    DescriptionView(description: newsFeed.description ?? "")),

            ///Image,Video,File View
            ///Image Type=0
            ///Video Type=1
            ///File Type=2
            const SizedBox(
              height: kSP5x,
            ),
            Flexible(
              child: ImageViewFileViewWidget(
                type: newsFeed.getFileType(),
                file: newsFeed.file ?? '',
                onTap: (file) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PopUpMenuView extends StatelessWidget {
  const PopUpMenuView({Key? key, required this.onSelect}) : super(key: key);
  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) => onSelect(value),
        icon: const Icon(
          Icons.more_vert,
          color: kSecondaryTextColor,
        ),
        itemBuilder: (_) {
          return const [
            PopupMenuItem(
              value: kEditText,
              child: EasyText(
                text: kEditText,
                textColor: kSecondaryTextColor,
              ),
            ),
            PopupMenuItem(
              value: kDeleteText,
              child: EasyText(
                text: kDeleteText,
                textColor: kSecondaryTextColor,
              ),
            )
          ];
        });
  }
}

class DescriptionView extends StatelessWidget {
  const DescriptionView({Key? key, required this.description})
      : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return description.isEmpty
        ? const SizedBox.shrink()
        : EasyText(
            text: description,
            maxLine: 4,
            fontSize: kFontSize16x,
            fontWeight: FontWeight.w500,
            textColor: kSecondaryTextColor,
          );
  }
}

class FloatingActionButtonItemView extends StatelessWidget {
  const FloatingActionButtonItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.navigateToNextScreen(
            context,
            AddNewsFeedPage(
            profileName: context.getHomePageBlocInstance().getProfileName,
        profileURL: context.getHomePageBlocInstance().getProfileURL,
        ));

      },
      backgroundColor: kPrimaryBgColor,
      child: const Icon(Icons.add),
    );
  }
}
