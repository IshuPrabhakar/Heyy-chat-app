import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social/main.dart';
import 'package:path/path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/common/common.dart';

import '../../common/bordered_button.dart';
import '../../common/image_options_bottom_sheet.dart';
import '../../common/something_went_wrong.dart';
import '../../dtos/user_info.dart';
import '../../entities/user_entity.dart';
import '../../helper/provider.dart';
import '../../helper/user_service.dart';
import '../../theme.dart';
import 'widget/appbar.dart';

class EditUserProfile extends ConsumerStatefulWidget {
  const EditUserProfile({super.key});

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => EditUserProfile(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditUserProfileState();
}

class _EditUserProfileState extends ConsumerState<EditUserProfile> {
  // TextFeild controllers
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final bioController = TextEditingController();
  final professionController = TextEditingController();

  // form validation global key
  final formKey = GlobalKey<FormState>();

  // local variables
  File? _image;
  String? userProfilePicPath;

  @override
  void initState() {
    super.initState();

    // prefilling save data
    if (admin != null) {
      nameController.text = admin!.name;
      mobileController.text = admin!.mobile ?? "";
      professionController.text = admin!.profession ?? "";
      bioController.text = admin!.bio ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: EditProfileScreenAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  // Profile Image Widget
                  _image == null
                      ? CircleAvatar(
                          backgroundColor: brightness == Brightness.light
                              ? Colors.grey.shade100
                              : AppColors.cardDark,
                          radius: 60,
                          child: Icon(
                            Icons.account_circle,
                            size: 120,
                            color: Colors.blue.shade600,
                          ), // Replace with lottie animation
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 60,
                        ),

                  // Edit button
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: CustomBorderedButton(
                      icon: Icons.camera_alt_rounded,
                      radius: 18,
                      onPressed: () {
                        showCustomBottomSheet(
                          context,
                          ImageSelectOptions(
                            onTap: (source) {
                              pickImage(source);
                              Navigator.of(context).pop();
                            },
                          ),
                          .25,
                          .25,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  children: [
                    // name
                    textField(
                      controller: nameController,
                      maxLines: 1,
                      icon: Icons.account_circle,
                      type: TextInputType.name,
                      prefixIconSize: 25,
                      hintText: "Name",
                      brightness: brightness,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-z]+$').hasMatch(value)) {
                          return "Enter a valid name.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    // mobile
                    textField(
                      controller: mobileController,
                      maxLines: 1,
                      icon: Icons.phone,
                      type: TextInputType.number,
                      prefixIconSize: 25,
                      hintText: "+91xxxxxx454",
                      brightness: brightness,
                      validator: (value) {
                        return null;
                      },
                    ),
                    // bio
                    textField(
                      controller: bioController,
                      maxLines: 2,
                      icon: Icons.edit,
                      type: TextInputType.multiline,
                      hintText: "Enter your bio here.",
                      prefixIconSize: 25,
                      brightness: brightness,
                      validator: (value) {
                        return null;
                      },
                    ),
                    // profession
                    textField(
                      controller: professionController,
                      maxLines: 1,
                      icon: Icons.work,
                      type: TextInputType.name,
                      prefixIconSize: 23,
                      hintText: "Profession",
                      brightness: brightness,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: RoundRectanlgeButton(
                      elevation: 2,
                      backgroundColor: Colors.white,
                      color: Colors.blueAccent.shade200,
                      onPressed: () => Navigator.of(context).pop(),
                      text: "Cancle",
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: RoundRectanlgeButton(
                      onPressed: () async {
                        var res = await saveUserInfo();
                        // if result is success
                        if (res == 200) {
                          Navigator.of(context).pop();
                        } else {
                          // in case of any failure
                          showCustomBottomSheet(
                            context,
                            SomethingWentWrong(),
                            .5,
                            .5,
                          );
                        }
                      },
                      text: "Save",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int?> saveUserInfo() async {
    if (formKey.currentState!.validate() && admin != null) {
      // saving data to the database
      admin!.profileUrl = userProfilePicPath;
      admin!.name = nameController.text;
      admin!.bio = bioController.text;
      admin!.mobile = mobileController.text;
      admin!.profession = professionController.text;

      await objectbox.user.put(admin!);

      return 200;
    }
    return 400;
  }

  void pickImage(ImageSource source) async {
    final imageHelper = ref.read(ImageHelperProvider);
    final files = await imageHelper.pickImage(source: source);

    if (files.isNotEmpty) {
      final croppedFile = await imageHelper.cropImage(
        imageFile: files.first,
      );

      // move file to permanent location
      final profilePath = await getExternalStorageDirectory();
      final path =
          "${join(profilePath!.path, 'Heyy')}/${nameController.text.replaceAll(" ", "")}.png";

      final savedFile = await croppedFile?.copy(path);

      if (savedFile != null) {
        setState(() {
          _image = File(savedFile.path);
          userProfilePicPath = savedFile.path;
        });
      }
    }
  }
}

Widget textField({
  required String hintText,
  required IconData icon,
  required TextInputType type,
  required int maxLines,
  required TextEditingController controller,
  required Brightness brightness,
  required String? Function(String?)? validator,
  required double prefixIconSize,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 15,
      left: 15,
      right: 15,
    ),
    child: TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      cursorColor: AppColors.secondary,
      keyboardType: type,
      decoration: InputDecoration(
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(
            left: 18.0,
            right: 12.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            icon,
            color: Colors.blue.shade400,
            size: prefixIconSize,
          ),
        ),
        hintText: hintText,
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
  );
}
