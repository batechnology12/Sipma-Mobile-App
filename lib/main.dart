import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/chat_controller.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/notification_model.dart';
import 'package:simpa/view/internet_page.dart';
import 'package:simpa/view/splash_view.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:simpa/widgets/bottumnavigationbar.dart';
import 'package:upgrader/upgrader.dart';
import 'view/from_notification_view/notification_comment_view.dart';
import 'view/from_notification_view/notification_reaction_screen_view.dart';
import 'view/select_role/select_user_role_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
      '::>>>::>>>:::>>>::>>>background message ${message.notification!.body}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  print(message.data);
  Map<String, String>? data = Map.from(message.data);

  // if (data['model'] == 'Chat') {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: 18,
  //           channelKey: 'basic_channel',
  //           title: message.data["title"],
  //           payload: data,
  //           body: message.data["body"]));
  // } else {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: 18,
  //           channelKey: 'basic_channel',
  //           title: message.notification!.title,
  //           payload: data,
  //           body: message.notification!.body));
  // }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  firebaseNotification();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            importance: NotificationImportance.High,
            playSound: true,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupName: 'Basic group',
            channelGroupkey: 'basic_channel_group')
      ],
      debug: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print('Message data: ${message.toString()}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');

      Map<String, String>? data = Map.from(message.data);

      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            icon: AwesomeNotifications.rootNativePath,
            title: message.notification!.title,
            body: message.notification!.body,
            payload: data),
      );
    }
  });

  AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    print(
        ":::--------:::::::notification datas:>>>>>>>>>>>>>>>:::-------------------::::::");
    print(receivedNotification.title);
    print(receivedNotification);
    print(receivedNotification.id);
    print(receivedNotification.summary);
    print(receivedNotification.payload);
    print(receivedNotification.body);
    print(receivedNotification.category);

    NotificationDataModel notificationModel =
        NotificationDataModel.fromJson(receivedNotification.payload);

    if (notificationModel.type == "like_Post") {
      Get.offAll(NotficationReactionView(
        likeCount: 100,
        postId: int.parse(notificationModel.id.toString()),
      ));
    } else if (notificationModel.type == "comment_Post") {
      Get.offAll(() => NotoficationCommentView(
            postId: int.parse(notificationModel.id.toString()),
          ));
    } else if (notificationModel.type == "Friend_Request") {
      Get.offAll(() => BottomNavigationBarExample(
            index: 1,
          ));
    } else if (notificationModel.type == "Friend_Request_accepted") {
      Get.offAll(() => BottomNavigationBarExample(
            index: 1,
          ));
    } else if (notificationModel.type == "chat") {
      Get.offAll(() => BottomNavigationBarExample(
            index: 2,
          ));
    } else {
      Get.offAll(() => BottomNavigationBarExample());
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(message.data);
    print(message.notification);
    if (message.data.isNotEmpty) {
      Map<String, String>? data = Map.from(message.data);
      NotificationDataModel notificationModel =
          NotificationDataModel.fromJson(data);

      if (notificationModel.type == "like_Post") {
        Get.offAll(NotficationReactionView(
          likeCount: 100,
          postId: int.parse(notificationModel.id.toString()),
        ));
      } else if (notificationModel.type == "comment_Post") {
        Get.offAll(() => NotoficationCommentView(
              postId: int.parse(notificationModel.id.toString()),
            ));
      } else if (notificationModel.type == "Friend_Request") {
        Get.lazyPut(() => ProfileController());
        Get.find<ProfileController>().initialIndex(1);
        Get.offAll(() => BottomNavigationBarExample(
              index: 1,
            ));
      } else if (notificationModel.type == "Friend_Request_accepted") {
        Get.offAll(() => BottomNavigationBarExample(
              index: 1,
            ));
      } else if (notificationModel.type == "chat") {
        Get.offAll(() => BottomNavigationBarExample(
              index: 2,
            ));
      } else {
        Get.offAll(() => BottomNavigationBarExample());
      }
    }
  });

  Get.put(AuthController());
  Get.put(PostsController());
  Get.put(ProfileController());
  Get.put(ChatController());
  runApp(const MyApp());
}

firebaseNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

Future<void> checkForUpdate() async {
  print(
      "******-__-***-__-***-__-***_-***-_****************---On update---*******************************************");
  InAppUpdate.checkForUpdate().then((info) {
    print(
        "%%%%%%%%%%%%%%% ------- ${info.availableVersionCode} -------- %%%%%%%%%%%%%%%");
    print(
        "%%%%%%%%%%%%%%% ------- ${info.updateAvailability} -------- %%%%%%%%%%%%%%%");
    print(
        "%%%%%%%%%%%%%%% ------- ${info.packageName} -------- %%%%%%%%%%%%%%%");

    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      InAppUpdate.performImmediateUpdate().catchError((e) {
        // showSnack(e.toString());
        return AppUpdateResult.inAppUpdateFailed;
      });
    }
  }).catchError((e) {
    // showSnack(e.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392, 850),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (o, n) => false,
        builder: (context, child) {
          return GetMaterialApp(
            builder: (context, child) {
              return StreamBuilder<ConnectivityResult>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    final connenctivityResult = snapshot.data;
                    if (connenctivityResult == ConnectivityResult.none ||
                        connenctivityResult == null)
                      return const InternetPage();

                    return child!;
                  });
            },
            debugShowCheckedModeBanner: false,
            home: UpgradeAlert(
                // child: const splash(),
                child:const splash()),
            theme: ThemeData(primarySwatch: Colors.grey),
          );
        });
  }
}
