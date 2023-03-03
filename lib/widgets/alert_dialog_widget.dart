import 'package:flutter/material.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/constant/strings.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';

class LoadingAlertDialogWidget extends StatelessWidget {
  const LoadingAlertDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
           SizedBox(
            width: kSP20x,
          ),
          EasyText(
            text: kLoadingText,
            fontWeight: FontWeight.w500,
            fontSize: kFontSize20x,
            textColor: kSecondaryTextColor,
          )
        ],
      ),

    );
  }
}
