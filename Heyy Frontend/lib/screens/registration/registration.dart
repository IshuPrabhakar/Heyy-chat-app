import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social/main.dart';
import 'package:social/theme.dart';

import '../../common/round_rect_button.dart';
import '../../common/something_went_wrong.dart';
import '../../common/utils.dart';
import '../../dtos/registration.dart';
import '../../helper/helper.dart';
import '../home/home_screen.dart';
import '../otp/otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      );

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // TextFeild controllers
  final emailController = TextEditingController();

  // form validation global key
  final formKey = GlobalKey<FormState>();

  // local variable
  int? otpSentStatus;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  void initState() {
    super.initState();

    admin!.email = "prabhakarishu5695@gmail.com";
    objectbox.user.put(admin!);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue.shade50,
                  ),
                  child: Lottie.asset(
                    "assets/teacher-girl-woman-tapping-phone.json",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add your phone email. We'll send you a verification code",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Phone number input box
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.secondary,
                        controller: emailController,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: brightness == Brightness.light
                                ? AppColors.textDark
                                : AppColors.textLight,
                          ),
                          hintText: "Enter your Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.secondary,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.secondary,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.secondary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.secondary,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.secondary,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,5}')
                                  .hasMatch(value)) {
                            return "Enter a valid email address.";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: 50,
                      child: RoundRectanlgeButton(
                        onPressed: () async => registerUser(),
                        text: "Register or Login",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (otpSentStatus == 200)
                      const Text(
                        "Otp sent successfully to your email",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Register a user
  Future<void> registerUser() async {
    // hide keyboard
    _focusNode.unfocus();

    // Check if user has already downloaded the app and
    // logged on before
    if (admin != null) {
      var res = admin!.email!.compareTo(
        emailController.text,
      );
      if (res == 0) {
        admin!.isLoggedIn = 1;
        objectbox.user.put(admin!);
        // if log in is successfull then navigate to the homescreen directly
        Navigator.of(context).push(HomeScreen.route());
      }
    }

    // check for email validation
    if (formKey.currentState!.validate()) {
      // sending otp to email
      var res =
          await AuthenticationApiService().sendOtp(email: emailController.text);

      // if response is not null
      if (res != null && res.runtimeType == RegistrationResponse) {
        // navigating to the next screen
        Navigator.of(context).push(
          OtpScreen.route(
            data: emailController.text,
            res: res as RegistrationResponse,
          ),
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
    }
  }
}


//final selectedCountry = ref.watch(countryCodeProvider);
// final emailController = ref.watch(phoneControllerProvider);
// phoneController.selection = TextSelection.fromPosition(
//   TextPosition(
//     offset: phoneController.text.length,
//   ),
// );
// Mobile number decoration
// Phone number Country code text box
// prefixIcon: Container(
//   padding: const EdgeInsets.only(
//       left: 8.0, top: 12, right: 8.0),
//   child: InkWell(
//     onTap: () {
//       showCountryPicker(
//         countryListTheme: CountryListThemeData(
//           bottomSheetHeight: 600,
//         ),
//         context: context,
//         onSelect: (value) {
//           ref
//               .read(countryCodeProvider.notifier)
//               .update((state) => value);
//         },
//       );
//     },
//     child: Text(
//       "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
//       style: TextStyle(
//         fontSize: 18,
//         color: brightness == Brightness.light
//             ? AppColors.textDark
//             : AppColors.textLight,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
// ),
// suffixIcon: phoneController.text.length > 9
//     ? Container(
//         height: 30,
//         width: 30,
//         margin: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.green,
//         ),
//         child: const Icon(
//           Icons.done,
//           color: Colors.white,
//           size: 17,
//         ),
//       )
//     : null,