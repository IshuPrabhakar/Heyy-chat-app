import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../theme.dart';

class ImageHandler {
  final ImagePicker _imagepicker;
  final ImageCropper _imageCropper;

  ImageHandler({
    ImageCropper? imageCropper,
    ImagePicker? imagePicker,
  })  : _imageCropper = imageCropper ?? ImageCropper(),
        _imagepicker = imagePicker ?? ImagePicker();

  // ImagePicker
  Future<List<XFile>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQualtiy = 100,
    CameraDevice preferredCameraDevice = CameraDevice.front,
    bool selectMultiple = false,
  }) async {
    if (selectMultiple) {
      return await _imagepicker.pickMultiImage(imageQuality: imageQualtiy);
    }
    final file = await _imagepicker.pickImage(
      source: source,
      imageQuality: imageQualtiy,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (file != null) return [file];
    return [];
  }

  // ImageCropper
  Future<File?> cropImage({
    required XFile imageFile,
    int compressQuality = 100,
    CropStyle cropStyle = CropStyle.circle,
  }) async {
    CroppedFile? croppedImage = await _imageCropper.cropImage(
      sourcePath: imageFile.path,
      compressQuality: compressQuality,
      cropStyle: cropStyle,
      uiSettings: [
        IOSUiSettings(),
        AndroidUiSettings(
          statusBarColor: AppColors.cardDark,
          showCropGrid: false,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}

class PermissionHandler {
  // For camera
  void requestCameraUsage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
  }

  void requestMicrophoneUsage() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      await Permission.microphone.request();
    }
  }

  void requestExternalStorageUsage() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }

  void requestContactUsage() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      await Permission.contacts.request();
    }
  }
}
