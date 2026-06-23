import 'package:petromaster/app/config/routes/route_name.dart';
import 'package:petromaster/presentation/Learn/view/typed_notes/src/typednoteviewer.dart';
import 'package:petromaster/presentation/settings/view/imageview.dart';
import 'package:petromaster/presentation/settings/view/studentdetail_page.dart';
import 'package:get/get.dart';

import '../../../presentation/Learn/bindings/audiolistbdng.dart';
import '../../../presentation/Learn/bindings/coursebinding.dart';
// import '../../../presentation/Learn/bindings/lessonbdng.dart';
import '../../../presentation/Learn/bindings/htmlviewbdng.dart';
import '../../../presentation/Learn/bindings/notelistbdng.dart';
import '../../../presentation/Learn/bindings/subjectbdng.dart';
import '../../../presentation/Learn/bindings/tabbarbdng.dart';
import '../../../presentation/Learn/bindings/topicbdng.dart';
import '../../../presentation/Learn/bindings/typednotebdng.dart';
import '../../../presentation/Learn/bindings/videobdng.dart';
import '../../../presentation/Learn/bindings/videoplayerbdng.dart';
// import '../../../presentation/Learn/view/lessons/lessonlist.dart';
import '../../../presentation/Learn/view/notes/src/imageview.dart';
import '../../../presentation/Learn/view/notes/src/pdfview.dart';
import '../../../presentation/Learn/view/studymaterialtab/studymaterialtab.dart';
import '../../../presentation/Learn/view/subjects/subjectlist.dart';
import '../../../presentation/Learn/view/topic/topiclist.dart';
import '../../../presentation/Learn/view/videos/videoplayer/Videolayer_headset.dart';
import '../../../presentation/common/bindings/catorybdng.dart';
import '../../../presentation/common/bindings/loginbdng.dart';
import '../../../presentation/common/bindings/splashscreenbdng.dart';
import '../../../presentation/common/view/AppNavbar/nav.dart';
import '../../../presentation/common/view/Home/home_page.dart';
import '../../../presentation/common/view/NavBar/nav.dart';
import '../../../presentation/common/view/Splashscren/splashscreen.dart';
import '../../../presentation/common/view/login/loginscreen.dart';
import '../../../presentation/exam/bindings/examattendbdng.dart';
import '../../../presentation/exam/bindings/examlistbdng.dart';
import '../../../presentation/exam/bindings/examresultbdng.dart';
import '../../../presentation/exam/view/examattend/examattend.dart';
import '../../../presentation/exam/view/examattend/src/examinstruction.dart';
import '../../../presentation/exam/view/examattend/src/examtimeout.dart';
import '../../../presentation/exam/view/examattend/src/examviolation.dart';
import '../../../presentation/exam/view/examsolution/examsolution.dart';
import '../../../presentation/settings/bndings/profilebdng.dart';
import '../../../presentation/settings/view/idcardview.dart';
import 'routig_widget.dart';

//?====================> App routes
class AppRoutes {
  static final routes = [
    getPage(RouteName.home, const Splash(), [SplashscreenBdng()]),
    getPage(RouteName.appDetails, const AppDetails(), []),
    // getPage(RouteName.appnav, const AppNavBar(), [
    //   Catorybdng(),
    // ]),
    getPage(RouteName.login, const LoginPage(), [Loginbdng()]),
    getPage(RouteName.navbar, const CourseDashboard(), [
      Loginbdng(),
      Coursebinding(),
      Examlistbdng(),
    ]),
    getPage(RouteName.sublist, const SubjectList(), [Subjectbdng()]),
    getPage(RouteName.topiclist, const TopicList(), [Topicbdng()]),
    getPage(RouteName.examinstruction, const ExamInstructions(), [
      Examattendbdng(),
    ]),
    getPage(RouteName.examresult, const Examsolution(), [Examresultbdng()]),
    getPage(RouteName.exampage, const ExamScreen(), []),
    getPage(RouteName.timeout, ModernTimeoutPage(), []),
    getPage(RouteName.examviolation, const ExamViolationScreen(), []),
    // getPage(RouteName.lessonlist, const Lessonlist(), [Lessonbdng()]),
    getPage(RouteName.studymaterialtab, const StudyMaterialTab(), [
      Tabbarbdng(),
      Videobdng(),
      Audiolistbdng(),
      Notelistbdng(),
      Typednotebdng(),
    ]),
    getPage(RouteName.pdfview, const PdfView(), []),
    getPage(RouteName.studentDetailsView, const StudentDetailsPage(), []),
    GetPage(name: RouteName.imgview, page: () => const ImageViewPage()),
    getPage(
      RouteName.videoplayer,
      const VideoPlayerScreen(
        // videoUrl: '',
      ),
      [],
    ),
    getPage(RouteName.idcardview, const IDCardWebView(), [Profilebdng()]),
    getPage(RouteName.htmlview, HtmlViewer(), [Htmlviewerbdng()]),
  ];
}
