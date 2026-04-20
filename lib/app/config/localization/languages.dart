import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcome': 'Welcome Back!',
          'login': 'Login to continue',
          'forgot_password': 'Forgot Password?',
          'login_button': 'Login',
          'email': 'Email',
          'email_hint': 'Enter your email address',
          'password': 'Password',
          'password_hint': 'Enter your password',
          'went_wrong': 'Oops! An unexpected error occurred',
          'checkinternet':
              'It seems there is something wrong with your internet connection. Please connect to the internet and start SPHERE again.',

        },
        // 'ml_IN': {
        //   'appname': 'Sidhartha central School: Stuents App',
        //   'nointernet': 'Oops...',
        //   'checkinternet':
        //       'It seems there is something wrong with your internet connection. Please connect to the internet and start SPHERE again.',
        //   'went_wrong': 'Oops! An unexpected error occurred',
        //   'went_wrong_desc':
        //       'We apologize for the inconvenience. Please try restarting the app. If the issue persists, feel free to contact our support team for assistance.',
        // },
      };
}
