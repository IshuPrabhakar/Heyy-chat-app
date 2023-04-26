import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/image_options_bottom_sheet.dart';
import '../../../common/utils.dart';
import '../../../helper/provider.dart';
import '../../../theme.dart';
import '../providers/chat_screen_provider.dart';
import 'package:image_picker/image_picker.dart';

class BottomInputField extends ConsumerStatefulWidget {
  const BottomInputField({
    Key? key,
    required this.focusNode,
  }) : super(key: key);
  final FocusNode focusNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomInputFieldState();
}

late BuildContext newContext;

class _BottomInputFieldState extends ConsumerState<BottomInputField> {
  File? _image;

  void showModal(Brightness brightness) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: .46,
          expand: false,
          builder: (context, controller) {
            return Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  _fileSelectOption(
                    "Photos & Videos",
                    Icons.image,
                    Colors.amber,
                    () {
                      Navigator.of(context).pop();
                      showCustomBottomSheet(
                        newContext,
                        ImageSelectOptions(
                          onTap: pickImage,
                        ),
                        .25,
                        .25,
                      );
                    },
                  ),
                  _fileSelectOption(
                    "Document",
                    Icons.insert_drive_file,
                    Colors.blue,
                    () async {
                      Navigator.of(context).pop();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.any,
                      );

                      if (result != null) {
                        List<File> files =
                            result.paths.map((e) => File(e!)).toList();
                      }
                      return;
                    },
                  ),
                  _fileSelectOption(
                    "Audio",
                    Icons.music_note,
                    Colors.orange,
                    () async {
                      Navigator.of(context).pop();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.audio,
                      );

                      if (result != null) {
                        List<File> files =
                            result.paths.map((e) => File(e!)).toList();
                      }
                      return;
                    },
                  ),
                  _fileSelectOption(
                    "Location",
                    Icons.location_on,
                    Colors.green,
                    () {},
                  ),
                  _fileSelectOption(
                    "Contact",
                    Icons.person,
                    Colors.purple,
                    () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Padding _fileSelectOption(
      String text, IconData icon, MaterialColor iconColor, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: iconColor.shade50,
          ),
          height: 50,
          width: 50,
          child: Icon(
            icon,
            size: 20,
            color: iconColor.shade400,
          ),
        ),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }

  // to pick pictures
  void pickImage(ImageSource source) async {
    final imageHelper = ref.read(ImageHelperProvider);
    final files = await imageHelper.pickImage(source: source);

    if (files.isNotEmpty) {
      final croppedFile = await imageHelper.cropImage(
        imageFile: files.first,
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    newContext = context;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = ref.watch(bottomTextFeildControllerProvider);
    return SafeArea(
      bottom: true,
      left: true,
      right: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3, top: 3),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 10,
              ),
              // Attachment button
              GestureDetector(
                onTap: () {
                  showModal(brightness);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 96, 106, 139),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),

              // Input Field
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.only(
                  left: 8,
                  bottom: 5,
                ),
                child: TextField(
                  controller: controller,
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.multiline,
                  cursorColor: AppColors.secondary,
                  enableIMEPersonalizedLearning: true,
                  textAlignVertical: TextAlignVertical.top,
                  scrollPhysics: BouncingScrollPhysics(),
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    suffixIconColor: AppColors.iconLight,
                    suffixIcon: InkWell(
                      child: Icon(
                        Icons.camera_alt,
                        size: 25,
                      ),
                      onTap: () {
                        showCustomBottomSheet(
                          context,
                          ImageSelectOptions(
                            onTap: pickImage,
                          ),
                          .25,
                          .25,
                        );
                      },
                    ),
                    hintText: "Type message...",
                    hintStyle: TextStyle(
                      color: brightness == Brightness.light
                          ? AppColors.textDark
                          : AppColors.textLight,
                    ),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    fillColor: brightness == Brightness.light
                        ? Colors.grey.shade100
                        : AppColors.cardDark,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),

              // Send button
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink,
                ),
                child: IconButton(
                  color: Colors.white,
                  splashRadius: 28,
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
