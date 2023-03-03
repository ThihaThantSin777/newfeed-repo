
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_news_feed_app/bloc/details_bloc.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/extensions.dart';
import 'package:simple_news_feed_app/view_items/home_page_view_items/home_page_view_items.dart';
import 'package:simple_news_feed_app/widgets/alert_dialog_widget.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';
import 'package:simple_news_feed_app/widgets/profile_widget.dart';

import '../widgets/image_video_file_view_widget.dart';
import 'add_news_feed_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key,required this.postID}) : super(key: key);
  final int postID;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailsBloc>(
        create: (_)=>DetailsBloc(postID),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryBgColor,
            centerTitle: true,
            title: const EasyText(
              text: kDetailsText,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Selector<DetailsBloc,bool>(
            selector: (_,bloc)=>bloc.isLoading,
            builder: (_,isLoading,child){
              if(isLoading){
                return const Center(child: CircularProgressIndicator(),);
              }
              return const NewsFeedDetailsItemView();
            },
          ),
        )
    );
  }
}


class NewsFeedDetailsItemView extends StatelessWidget {
  const NewsFeedDetailsItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DetailsBloc,NewsFeedVO?>(
      selector: (_,bloc)=>bloc.getNewsFeedVO,
      builder: (context,newsFeed,child){
        if(newsFeed!=null){
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
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const LoadingAlertDialogWidget());
                          context
                              .getDetailsPageBlocInstance()
                              .deletePost(newsFeed.id ?? 0)
                              .then((value) {
                            context.navigateBack(context);
                          }).catchError((error) {
                            context.navigateBack(context);
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
        return const SizedBox.shrink();
      }
    );
  }
}
