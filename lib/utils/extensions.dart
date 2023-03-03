import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_news_feed_app/bloc/add_news_feed_bloc.dart';
import 'package:simple_news_feed_app/bloc/details_bloc.dart';
import 'package:simple_news_feed_app/bloc/home_page_bloc.dart';
import 'package:simple_news_feed_app/utils/enums.dart';

extension Navigation on BuildContext {
  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  HomePageBloc getHomePageBlocInstance() => read<HomePageBloc>();

  AddNewsFeedBloc getAddNewsFeedPageBlocInstance() => read<AddNewsFeedBloc>();

  DetailsBloc getDetailsPageBlocInstance() => read<DetailsBloc>();
}

extension FileExtension on File {
  FileType getFileType() {
    if ((path.endsWith(".png") ?? false) ||
        (path.endsWith(".jpg") ?? false) ||
        (path.endsWith(".jpeg") ?? false)) {
      return FileType.image;
    }
    if ((path.endsWith(".mkv") ?? false) ||
        (path.endsWith(".mp4") ?? false) ||
        (path.endsWith(".mov") ?? false)) {
      return FileType.video;
    }
    if ((path.endsWith(".pdf") ?? false) || (path.endsWith(".txt") ?? false)) {
      return FileType.file;
    }
    return FileType.none;
  }
}
