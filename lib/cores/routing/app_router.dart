import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:youtube_clone/cores/routing/routes.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/account/account_page.dart';
import 'package:youtube_clone/features/auth/pages/login_page.dart';
import 'package:youtube_clone/features/channel/my_channel/pages/my_channel_screen.dart';
import 'package:youtube_clone/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:youtube_clone/features/content/long_video/components/video.dart';
import 'package:youtube_clone/features/content/long_video/model/video_model.dart';
import 'package:youtube_clone/features/content/long_video/video_details_page.dart';
import 'package:youtube_clone/features/content/short_video/pages/short_video_details_page.dart';
import 'package:youtube_clone/features/content/short_video/pages/short_video_screen.dart';
import '../../features/auth/model/user_model.dart';
import '../../features/auth/pages/username_page.dart';
import '../../home_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LoginPage();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Loader();
                }
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final user = FirebaseAuth.instance.currentUser;
                    if (FirebaseAuth.instance.currentUser == null) {
                      return UsernamePage(
                        displayName: user!.displayName!,
                        profilePic: user.photoURL!,
                        email: user.email!,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Loader();
                    }
                    return const HomePage();
                  },
                );
              }),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case Routes.mainVideoScreen:
        return MaterialPageRoute(
          builder: (_) {
            if (arguments is VideoModel) {
              return Video(video: arguments);
            } else {
              return const ErrorPage();
            }
          },
        );

      case Routes.myChannelScreen:
        return MaterialPageRoute(
          builder: (_) => const MyChannelScreen(),
        );
      case Routes.userChannelPage:
        return MaterialPageRoute(
          builder: (_) {
            if (arguments is String) {
              return UserChannelPage(userId: arguments);
            } else {
              return const ErrorPage();
            }
          },
        );
      case Routes.longVideoDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const VideoDetailsPage(),
        );
      case Routes.shortVideoDetailsScreen:
        return MaterialPageRoute(builder: (_) {
          if (arguments is File) {
            return ShortVideoDetailsPage(video: arguments);
          } else {
            return const ErrorPage();
          }
        });
      case Routes.shortVideoViewScreen:
        return MaterialPageRoute(builder: (_) {
          if (arguments is File) {
            return ShortVideoScreen(shortVideo: arguments);
          } else {
            return const ErrorPage();
          }
        });
      case Routes.accountPage:
        return MaterialPageRoute(builder: (_) {
          if (arguments is UserModel) {
            return AccountPage(user: arguments);
          } else {
            return const ErrorPage();
          }
        });
      default:
        return null;
    }
  }
}
