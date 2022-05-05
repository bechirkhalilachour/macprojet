import 'package:flutter/widgets.dart';
import 'package:macprojet/screens/cart/cart_screen.dart';
import 'package:macprojet/screens/complete_profile/complete_profile_screen.dart';
import 'package:macprojet/screens/details/details_screen.dart';
import 'package:macprojet/screens/forgot_password/forgot_password_screen.dart';
import 'package:macprojet/screens/home/home_screen.dart';
import 'package:macprojet/screens/otp/otp_screen.dart';
import 'package:macprojet/screens/profile/profile_screen.dart';
import 'package:macprojet/screens/sign_in/sign_in_screen.dart';
import 'package:macprojet/screens/splash/splash_screen.dart';
import 'package:macprojet/screens/news/news_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  NewsScreen.routeName: (context) => NewsScreen(),
};
