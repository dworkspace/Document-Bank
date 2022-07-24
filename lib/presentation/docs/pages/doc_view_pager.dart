import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:document_bank/core/blocs/download/download_cubit.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/router/arguments/doc_view_pager_args.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocViewPager extends StatefulWidget {
  const DocViewPager({
    Key? key,
    required this.args,
  }) : super(key: key);
  final DocViewPagerArgs args;

  @override
  State<DocViewPager> createState() => _DocViewPagerState();
}

class _DocViewPagerState extends State<DocViewPager> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.args.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadCubit, DownloadState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          DialogUtils.buildLoadingDialog(
            context,
            title: "Downloading please wait",
          );
        } else if (state.status.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(
            context,
            title: "Download",
            message: "Download failed",
            onClose: () => Navigator.pop(context),
          );
        } else if (state.status.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Download",
            message: "Download Success",
            onDone: () => Navigator.pop(context),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.args.documents[currentIndex].folder),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                IconAssets.reminderWatchImg,
                color: ColorManager.darkBlue,
                height: 18.0,
                width: 18.0,
              ),
            ),
            BlocBuilder<DownloadCubit, DownloadState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<DownloadCubit>()
                        .downloadImage(widget.args.documents[currentIndex]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.cloud_download,
                      color: ColorManager.darkBlue,
                      size: 18.0,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: CarouselSlider.builder(
            itemCount: widget.args.documents.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: widget.args.documents[currentIndex].photo,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              );
            },
            options: CarouselOptions(
              reverse: false,
              autoPlay: false,
              height: MediaQuery.of(context).size.height,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 0.8,
              initialPage: currentIndex,
            ),
          ),
        ),
      ),
    );
  }
}
