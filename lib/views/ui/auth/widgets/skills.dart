import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/auth/add_skills.dart';
import 'package:jobhubv2_0/models/response/auth/skills.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/ui/auth/widgets/add_skill.dart';
import 'package:jobhubv2_0/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  late Future<List<Skills>> skillsList;
  TextEditingController skill = TextEditingController();

  @override
  void initState() {
     getSkills();
    super.initState();
  }

  Future<List<Skills>> getSkills() {
    skillsList = AuthHelper.getSkills();
    return skillsList;
  }

  @override
  Widget build(BuildContext context) {
    var addSkillNotifier = Provider.of<AddSkillNotifier>(context);
    var zoomNotifier = Provider.of<ZoomNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: 'Skills',
                  style: appStyle(15, Colors.black, FontWeight.w600)),
              Consumer<AddSkillNotifier>(
                builder: (context, addSkillNotifier, child) {
                  return addSkillNotifier.addSkill != true
                      ? GestureDetector(
                          onTap: () {
                            addSkillNotifier.addSkill =
                                !addSkillNotifier.addSkill;
                          },
                          child: const Icon(
                              MaterialCommunityIcons.plus_circle_outline,
                              color: Colors.black,
                              size: 20))
                      : GestureDetector(
                          onTap: () {
                            addSkillNotifier.addSkill =
                                !addSkillNotifier.addSkill;
                          },
                          child: const Icon(AntDesign.closecircleo,
                              color: Colors.black, size: 20));
                },
              )
            ],
          ),
        ),
        addSkillNotifier.addSkill == true
            ? AddSkills(
                skill: skill,
                onTap: () {
                  addSkillNotifier.addSkill = false;

                  AddSkill model = AddSkill(skill: skill.text);

                  String newModel = addSkillToJson(model);

                  AuthHelper.addSkill(newModel);
                  zoomNotifier.currentIndex = 4;
                  Get.to(() => const MainScreen());
                },
              )
            : SizedBox(
                height: hieght * 0.04,
                child: FutureBuilder<List<Skills>>(
                    future: skillsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error ${snapshot.error}");
                      } else {
                        var skill = snapshot.data;
                        return ListView.builder(
                            itemCount: skill!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onLongPress: () {
                                  addSkillNotifier.setSkill(skill[index].id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(kLightGrey.value),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Row(
                                    children: [
                                      ReusableText(
                                          text: skill[index].skill,
                                          style: appStyle(10, Colors.black,
                                              FontWeight.w500)),
                                      const WidthSpacer(width: 10),
                                      skill[index].id ==
                                              addSkillNotifier.addSkillId
                                          ? GestureDetector(
                                              onTap: () {
                                                AuthHelper.deleteSkill(
                                                    addSkillNotifier
                                                        .addSkillId);
                                                addSkillNotifier.setSkill('');
                                                zoomNotifier.currentIndex = 4;
                                                Get.to(
                                                    () => const MainScreen());
                                              },
                                              child: const Icon(
                                                  AntDesign.delete,
                                                  color: Colors.black,
                                                  size: 12))
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              )
      ],
    );
  }
}
