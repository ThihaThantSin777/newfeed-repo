import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/widgets/easy_text.dart';
import 'package:simple_news_feed_app/widgets/fade_in_image_widget.dart';
import '../../utils/enums.dart';

class ImageViewFileViewWidget extends StatelessWidget {
  const ImageViewFileViewWidget(
      {Key? key,
      required this.type,
      required this.file,
      required this.onTap,
        this.selectFile,
      this.isFromNetwork = true})
      : super(key: key);
  final FileType type;
  final String file;
  final bool isFromNetwork;
  final Function(String) onTap;
  final File ? selectFile;

  @override
  Widget build(BuildContext context) {
    return type == FileType.none
        ? const SizedBox.shrink()
        : type == FileType.image
            ? ImageView(
              fileSelect: selectFile,
                images: file,
                isFromNetwork: isFromNetwork,
              )
            : type == FileType.video
                ? VideoView(
                    videoLinkURL: file,
                  )
                : FileView(
                    onTap: () => onTap(file),
                  );
  }
}

class FileView extends StatelessWidget {
  const FileView({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () => onTap(),
            child: const Icon(
              Icons.file_present,
              size: kFileIconSize,
            )),
        const EasyText(
          text: "File",
          fontWeight: FontWeight.w600,
          fontSize: kFontSize16x,
        )
      ],
    );
  }
}

class VideoView extends StatelessWidget {
  const VideoView({Key? key, required this.videoLinkURL}) : super(key: key);
  final String videoLinkURL;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.images, required this.isFromNetwork,required this.fileSelect})
      : super(key: key);
  final String images;
  final bool isFromNetwork;
  final File  ?fileSelect;

  @override
  Widget build(BuildContext context) {
    return FadeInImageWidget(
      fileImage: fileSelect,
      image: images,
      isCircle: false,
      isFromNetwork: isFromNetwork,
    );
  }
}
