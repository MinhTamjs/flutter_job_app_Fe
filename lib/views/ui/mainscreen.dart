import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/views/common/drawer/drawerScreen.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/ui/applicatons/applied_jobs_page.dart';
import 'package:jobhubv2_0/views/ui/auth/profile.dart';
import 'package:jobhubv2_0/views/ui/bookmarks/bookmarks.dart';
import 'package:jobhubv2_0/views/ui/chat/chat_list.dart';
import 'package:jobhubv2_0/views/ui/home/homepage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(
            indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            },
          ),
          mainScreen: currentSreen(),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(kLightBlue.value),
        );
      },
    );
  }

  Widget currentSreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    

    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsList();
      case 2:
        return const BookMarkPage();
      case 3:
        return const AppliedJobsPage();
      case 4:
        return const ProfilePage(
          drawer: true,
        );
      default:
        return const HomePage();
    }
  }
}
