import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//text style
TextStyle ktextstyle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
TextStyle ktextstyle22 =
    const TextStyle(fontWeight: FontWeight.w600, fontSize: 22);
TextStyle ktextstyle15gry = const TextStyle(
    fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey);

var primaryfont = const TextStyle();

//sized box
const SizedBox ksizedbox10 = SizedBox(height: 10);
const SizedBox ksizedbox30 = SizedBox(height: 30);
const SizedBox ksizedbox40 = SizedBox(height: 40);
const SizedBox kwidth10 = SizedBox(
  width: 10,
);

// const SizedBox ksizedbox10 = SizedBox(height: 10);
// const SizedBox ksizedbox10 = SizedBox(height: 10);

//colors
Color kgrey = Colors.grey;
Color kblue = const Color(0xFF3C73B1);
Color kwhite = Colors.white;

//image
final kpeople = Image.asset('assets/images/profile.svg');
final kimgadd = SvgPicture.asset(
  'assets/images/add.svg',
  color: Colors.white,
);
final klikebutton = SvgPicture.asset('assets/images/like_button.svg');
final ksentbutton = SvgPicture.asset('assets/images/send_button.svg');
final kcomentbutton = SvgPicture.asset('assets/images/Group (1).svg');
final ksharebutton = Image.asset(
  'assets/images/send.png',
  height: 20,
  width: 20,
);
final kfilterbutton = SvgPicture.asset(
  'assets/images/Group.svg',
  color: Colors.white,
);
final ksearch = SvgPicture.asset(
  'assets/images/Vector.svg',
  color: Colors.white,
);

final ksearchblack = SvgPicture.asset(
  'assets/images/Vector.svg',
);
final ksettingsicon = SvgPicture.asset('assets/images/settings.svg');
final kforgotImage = Image.asset('assets/images/Asset 11 4.png');
final kverifiyforgotimage = Image.asset('assets/images/Group 120.png');
final ksucessfullforgotimage = Image.asset('assets/images/Group 121.png');
final kcreatenewpwdimage = Image.asset('assets/images/Group 117.png');
final kdeleteUserimage = Image.asset(
  'assets/images/delete_user.png',
  fit: BoxFit.cover,
);
final kheartbutton = SvgPicture.asset('assets/images/heart.svg');
