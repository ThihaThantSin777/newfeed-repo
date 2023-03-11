import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_news_feed_app/constant/dimens.dart';
import 'package:simple_news_feed_app/utils/assets_images.dart';

class FadeInImageWidget extends StatelessWidget {
  const FadeInImageWidget(
      {Key? key,
      required this.image,
      this.fileImage,
      this.isFromNetwork = true,
      this.isCircle = true})
      : super(key: key);
  final String image;
  final bool isCircle;
  final bool isFromNetwork;
  final File? fileImage;

  @override
  Widget build(BuildContext context) {
    return isFromNetwork
        ? NetworkImageView(
            image: image,
            isCircle: isCircle,
          )
        : FileImageView(
            isCircle: isCircle,
            fileImage: fileImage,
          );
  }
}

class NetworkImageView extends StatelessWidget {
  const NetworkImageView(
      {Key? key, required this.image, this.fileImage, this.isCircle = true})
      : super(key: key);
  final String image;
  final bool isCircle;
  final File? fileImage;

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP10x),
              child: FadeInImage(
                  placeholder: AssetImage(AssetsImages.kDefaultImagePath),
                  image: NetworkImage(image)),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(kSP10x),
            child: FadeInImage(
                placeholder: AssetImage(AssetsImages.kDefaultImagePath),
                image: NetworkImage(image)),
          );
  }
}

class FileImageView extends StatelessWidget {
  const FileImageView({Key? key, this.fileImage, this.isCircle = true})
      : super(key: key);
  final bool isCircle;
  final File? fileImage;

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP10x),
              child: FadeInImage(
                  placeholder: AssetImage(AssetsImages.kDefaultImagePath),
                  image: FileImage(fileImage!)),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(kSP10x),
            child: FadeInImage(
                placeholder: AssetImage(AssetsImages.kDefaultImagePath),
                image: FileImage(fileImage!)),
          );
  }
}
