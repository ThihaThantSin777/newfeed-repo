import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/data/vos/news_feed_vo.dart';
import 'package:simple_news_feed_app/utils/extensions.dart';
import 'package:simple_news_feed_app/utils/file_picker_utils.dart';
import 'package:simple_news_feed_app/widgets/alert_dialog_widget.dart';

import '../../bloc/add_news_feed_bloc.dart';

class PostTextFiledItemView extends StatelessWidget {
  const PostTextFiledItemView({super.key, required this.newsFeedVO});

  final NewsFeedVO? newsFeedVO;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: (newsFeedVO != null)
          ? TextEditingController(text: newsFeedVO?.description)
          : null,
      onChanged: (text) {
        context.getAddNewsFeedPageBlocInstance().setCanPostStatus(text);
      },
      maxLines: null,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: kSP10x),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: kFeelingText,
      ),
    );
  }
}

class RemoveImageItemView extends StatelessWidget {
  const RemoveImageItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.getAddNewsFeedPageBlocInstance().setSelectFileNull();
      },
      child: const Padding(
        padding: EdgeInsets.only(right: kSP5x),
        child: Icon(
          Icons.delete,
          size: kDeleteIconSize,
          color: kRedColor,
        ),
      ),
    );
  }
}

class IconButtonView extends StatelessWidget {
  const IconButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.file_present_rounded),
      onPressed: () {
        getFiles().then((file) {
          context.getAddNewsFeedPageBlocInstance().setSelectFile(file);
        });
      },
    );
  }
}

class FloatingActionView extends StatelessWidget {
  const FloatingActionView({super.key, required this.canPost});

  final bool canPost;

  @override
  Widget build(BuildContext context) {
    return Selector<AddNewsFeedBloc, NewsFeedVO?>(
      selector: (context, bloc) => bloc.getNewsFeedVO,
      builder: (context, newsFeed, _) => FloatingActionButton(
        onPressed: canPost
            ? () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => const LoadingAlertDialogWidget());
                context
                    .getAddNewsFeedPageBlocInstance()
                    .onTapPost()
                    .then((value) {
                  context.navigateBack(context);
                  context.navigateBack(context);
                }).catchError((error) {
                  context.navigateBack(context);
                });
              }
            : null,
        backgroundColor: (canPost) ? kPrimaryBgColor : kGreyColor,
        child: Icon((newsFeed == null) ? Icons.add : Icons.edit),
      ),
    );
  }
}
