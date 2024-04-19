import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/models/response/agent/getAgent.dart';
import 'package:jobhubv2_0/models/response/jobs/get_job.dart';

const kDark = Color.fromARGB(255, 0, 0, 0);
const kLight = Color.fromARGB(255, 214, 228, 214);
const kLightGrey = Color.fromARGB(44, 42, 43, 43);
const kDarkGrey = Color.fromARGB(255, 51, 47, 47);
const kOrange = Color.fromARGB(255, 114, 116, 18);
const kLightBlue = Color.fromARGB(255, 46, 165, 173);
const kDarkBlue = Color(0xff1c153e);
const kLightPurple = Color(0xff6352c5);
const kDarkPurple = Color(0xff6352c5);

double hieght = 812.h;
double width = 375.w;



List<String> requirements = [
  "Design and Build sophisticated and highly scalable apps using Flutter.",
  "Build custom packages in Flutter using the functionalities and APIs already available in native Android and IOS.",
  "Translate and Build the designs and Wireframes into high quality responsive UI code.",
  "Explore feasible architectures for implementing new features.",
  "Resolve any problems existing in the system and suggest and add new features in the complete system.",
  "Suggest space and time efficient Data Structures.",
];

String desc =
    "Flutter Developer is responsible for running and designing product application features across multiple devices across platforms. Flutter is Google's UI toolkit for building beautiful, natively compiled apps for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";

List<String> skills = [
  "Node JS",
  "Java SpringBoot",
  "Flutter and Dart",
  "Firebase",
  "AWS",
];

// List<String> profile = [];
String userUid = '';
String name = '';
String profile = '';

  List<dynamic> salaries = [
    {
    'title': 'Monthly',
    'isSelected': false,
  },

   {
    'title': 'Weekly',
    'isSelected': false,
  },

   {
    'title': 'Yearly',
    'isSelected': false,
  },
  ];

  late GetJobRes editable;
  late GetAgent? agentInfo;
  List<String> bookmarks = [];

