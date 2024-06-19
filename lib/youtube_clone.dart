import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cores/routing/app_router.dart';
import 'cores/routing/routes.dart';


class YoutubeClone extends ConsumerWidget {
  final AppRouter appRouter;
  const YoutubeClone( {super.key,required this.appRouter,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Youtube Clone",
        initialRoute:Routes.loginScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}