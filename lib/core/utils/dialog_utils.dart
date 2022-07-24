import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  DialogUtils._();

  static void buildLoadingDialog(
    BuildContext context, {
    String title = "Loading...",
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildErrorMessageDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        color: ColorManager.primaryBloodColor,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildSuccessMessageDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onDone,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onDone,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_right_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildSetReminderDialog({
    required BuildContext context,
    VoidCallback? onNoClick,
    VoidCallback? onYesClick,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to set reminder?",
                    textAlign: TextAlign.center,
                    style: getSemiBoldStyle(
                        color: ColorManager.blackColor, fontSize: 18.0),
                  ),
                  Text(
                    "You need to set reminder to get remind on future. Please set reminder if you wish in future",
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onNoClick,
                          child: Container(
                            width: 80.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: ColorManager.redColor,
                            ),
                            child: Text(
                              "No",
                              style: getMediumStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onYesClick,
                          child: Container(
                            width: 80.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: ColorManager.primaryYellow,
                            ),
                            child: Text(
                              "Yes",
                              style: getMediumStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void buildImageViewDialog(
      {required BuildContext context, required String url}) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => const LinearProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        });
  }

  static void buildPhotoPickerDialog(
      {required BuildContext context,
      VoidCallback? onCameraTap,
      VoidCallback? onGalleryTap}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            bottomLeft: Radius.circular(18.0),
                          )),
                      padding: const EdgeInsets.all(24.0),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onGalleryTap,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primaryYellow,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0),
                          )),
                      padding: const EdgeInsets.all(24.0),
                      child: const Icon(
                        Icons.photo,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<DateTime?> inputDateFromUser(BuildContext context) async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    return _pickedDate;
  }

  static Future<TimeOfDay?> inputTimeFromUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
    );
    return pickedTime;
  }
}
