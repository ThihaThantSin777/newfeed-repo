import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_news_feed_app/bloc/home_page_bloc.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/extensions.dart';
import 'package:simple_news_feed_app/view_items/home_page_view_items/home_page_view_items.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';

import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const FloatingActionButtonItemView(),
        appBar: AppBar(
          backgroundColor: kPrimaryBgColor,
          leading: const Icon(Icons.menu),
          centerTitle: true,
          title: const EasyText(
            text: kAppTitle,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Selector<HomePageBloc, List<NewsFeedVO>?>(
          selector: (_, bloc) => bloc.getNewsFeedList,
          builder: (_, newsFeedList, __) {
            if (newsFeedList == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (newsFeedList.isEmpty) {
              return const Center(
                child: EasyText(
                  text: kNoDataText,
                  textColor: kSecondaryTextColor,
                ),
              );
            }
            return ListView.separated(
                padding: const EdgeInsets.all(kSP10x),
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        context.navigateToNextScreen(
                            context,
                            DetailsPage(
                              postID: newsFeedList[index].id ?? 0,
                            ));
                      },
                      child: NewsFeedItemView(newsFeed: newsFeedList[index]),
                    ),
                separatorBuilder: (_, index) => const SizedBox(
                      height: kSP10x,
                    ),
                itemCount: newsFeedList.length);
          },
        ),
      ),
    );
  }
}
