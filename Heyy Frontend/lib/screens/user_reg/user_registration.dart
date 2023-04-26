import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social/common/common.dart';
import 'package:social/dtos/user_info.dart';
import 'package:social/main.dart';
import 'package:social/screens/home/home_screen.dart';
import 'package:social/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

import '../../common/bordered_button.dart';
import '../../common/image_options_bottom_sheet.dart';
import '../../common/something_went_wrong.dart';
import '../../helper/helper.dart';
import '../../entities/user_entity.dart';
import '../../dtos/verification.dart';

class UserRegistration extends ConsumerStatefulWidget {
  const UserRegistration({
    super.key,
    required this.verificationResponse,
    required this.Email,
    required this.Uuid,
  });

  // this is for navigation
  static Route route({
    required String email,
    required VerificationResponse res,
    required String uuid,
  }) =>
      MaterialPageRoute(
        builder: (context) => UserRegistration(
          verificationResponse: res,
          Email: email,
          Uuid: uuid,
        ),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRegistrationState();

  final VerificationResponse verificationResponse;
  final String Email;
  final String Uuid;
}

class _UserRegistrationState extends ConsumerState<UserRegistration> {
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
  int isUserInfoSaved = 0;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mobileController.dispose();
    bioController.dispose();
    professionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // ask for permission
    final permissionHandler = ref.read(PermissionHandlerProvider);
    permissionHandler.requestCameraUsage();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
          child: Center(
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomBorderedButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
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
                              onTap: (source) async {
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
                Form(
                  key: formKey,
                  child: Container(
                    child: Column(
                      children: [
                        // name
                        textField(
                          controller: nameController,
                          maxLines: 1,
                          icon: Icons.account_circle,
                          type: TextInputType.name,
                          hintText: "Name",
                          brightness: brightness,
                          prefixIconSize: 25,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[a-z A-z]+$').hasMatch(value)) {
                              return "Enter a valid name.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        // email
                        // phone interchangebaly
                        textField(
                          controller: mobileController,
                          maxLines: 1,
                          icon: Icons.phone_android,
                          type: TextInputType.number,
                          hintText: "+91xxxxxx454",
                          brightness: brightness,
                          prefixIconSize: 25,
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
                          hintText: "Profession",
                          brightness: brightness,
                          prefixIconSize: 23,
                          validator: (value) {
                            return null;
                          },
                        ),
                        // bio
                        textField(
                          controller: bioController,
                          maxLines: 2,
                          icon: Icons.edit,
                          type: TextInputType.name,
                          hintText: "Enter your bio here.",
                          brightness: brightness,
                          prefixIconSize: 25,
                          validator: (value) {
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 50,
                  child: RoundRectanlgeButton(
                    onPressed: () async {
                      var res = await saveUserInfo();
                      // if result is success
                      if (res == 200) {
                        // navigate to the home screen
                        Navigator.of(context).push(
                          HomeScreen.route(),
                        );
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
                    text: "Continue",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // save user profile information
  Future<int?> saveUserInfo() async {
    if (formKey.currentState!.validate()) {
      var res = await UserApiService().UpdateUserInfo(
        userinfo: UserInfo(
          name: nameController.text,
          bio: bioController.text,
          mobile: mobileController.text,
          profession: professionController.text,
        ),
        Uuid: widget.Uuid,
        JwtToken: widget.verificationResponse.jwtToken,
      );

      // saving data to the database
      await objectbox.user.put(
        User(
          profileUrl: userProfilePicPath,
          name: nameController.text,
          bio: bioController.text,
          mobile: mobileController.text,
          profession: professionController.text,
          exp: 7,
          jwtToken: widget.verificationResponse.jwtToken,
          refreshToken: widget.verificationResponse.refreshToken!.token,
          uuid: widget.Uuid,
          isLoggedIn: 1,
          id: isUserInfoSaved,
          email: widget.Email,
        ),
      );

      setState(() {
        // To prevent new user creation in case of any failure
        isUserInfoSaved = 1;
      });

      return res;
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
