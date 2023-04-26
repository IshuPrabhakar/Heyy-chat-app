import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:social/dtos/error.dart';

import '../../common/bordered_button.dart';
import '../../common/common.dart';
import '../../common/something_went_wrong.dart';
import '../../dtos/registration.dart';
import '../../dtos/verification.dart';
import '../../theme.dart';
import '../user_reg/user_registration.dart';
import '../../helper/helper.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.emailorMobile,
    required this.response,
  });

  // this is for navigation
  static Route route({
    required String data,
    required RegistrationResponse res,
  }) =>
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          emailorMobile: data,
          response: res,
        ),
      );

  final String emailorMobile;
  final RegistrationResponse response;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? OtpCode;
  int? otpSentStatus;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue.shade50,
                  ),
                  child: Lottie.asset(
                    "assets/enter-otp.json",
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        "Enter the OTP send to your email",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // show email preview
                      if (!widget.emailorMobile.isEmpty)
                        Text(
                          "${widget.emailorMobile}",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(
                        height: 25,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.secondary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (value) {
                          setOtp(value);
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: RoundRectanlgeButton(
                          onPressed: verifyOtp,
                          text: "Verify",
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          overlayColor: MaterialStatePropertyAll<Color>(
                            brightness == Brightness.light
                                ? Colors.blue.shade50
                                : Colors.white10,
                          ),
                        ),
                        child: Text(
                          "Resend new code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        onPressed: () => resendOtp(
                          widget.emailorMobile,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (otpSentStatus == 200)
                        Text(
                          "Otp sent successfully to your email",
                          style: TextStyle(fontSize: 14, color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // set otp
  void setOtp(String otp) {
    setState(() {
      OtpCode = otp;
    });
  }

  // verify otp
  void verifyOtp() async {
    if (OtpCode!.isNotEmpty && OtpCode!.length == 6) {
      // validating the response
      var response = await AuthenticationApiService().verifyOtp(
        request: VerificationRequest(
          otp: OtpCode!,
          email: widget.emailorMobile,
          hash: widget.response.Hash,
          otpSentTime: widget.response.OtpSentTime,
        ),
      );
      if (response != null && response.runtimeType == VerificationResponse) {
        var res = response as VerificationResponse;
        // navigating to the next screen
        Navigator.of(context).push(
          UserRegistration.route(
            res: res,
            uuid: res.refreshToken!.uuid,
            email: widget.emailorMobile,
          ),
        );
      } else if (response != null && response.runtimeType == HeyyError) {
        var err = response as HeyyError;
        showSnackBar(
          context,
          err.desc,
        );
      }
    } else {
      showSnackBar(
        context,
        "Enter 6-Digit code",
      );
    }
  }

  void resendOtp(String email) async {
    var res = await AuthenticationApiService().sendOtp(email: email);

    if (res != null) {
      setState(() {
        otpSentStatus = 200;
      });

      return;
    }

    // in case of any failure
    showCustomBottomSheet(
      context,
      SomethingWentWrong(),
      .5,
      .5,
    );
  }
}
