import 'package:flutter/material.dart';
import 'package:simple_news_feed_app/constant/colors.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';
import 'package:simple_news_feed_app/widgets/fade_in_image_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key,
      required this.profileName,
      required this.profileURL,
      required this.subDescription,
      required this.trailingWidget})
      : super(key: key);
  final String profileName;
  final String profileURL;
  final String subDescription;
  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: kTransparentColor,
          backgroundImage: NetworkImage(profileURL),
        ),
        const SizedBox(
          width: kSP5x,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EasyText(
              text: profileName,
              fontSize: kFontSize16x,
              fontWeight: FontWeight.w600,
              textColor: kSecondaryTextColor,
            ),
            const SizedBox(
              height: kSP5x,
            ),
            EasyText(
              text: subDescription,
              fontSize: kFontSize13x,
              fontWeight: FontWeight.w300,
              textColor: kSecondaryTextColor,
            ),
          ],
        ),
        const Spacer(),
        trailingWidget
      ],
    );
  }
}
