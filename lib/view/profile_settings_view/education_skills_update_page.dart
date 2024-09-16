import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/view/alert_box/widgets/textfield.dart';

class EducationSkillsUpdatePage extends StatefulWidget {
  const EducationSkillsUpdatePage({super.key});

  @override
  State<EducationSkillsUpdatePage> createState() => _EducationSkillsUpdatePageState();
}

class _EducationSkillsUpdatePageState extends State<EducationSkillsUpdatePage> {

  final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    profileController.getEducationalSkillsApi();
    profileController.getProfile();
  }

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  String selectdt = formatDate(DateTime.now().subtract(const Duration(days: 0)), [
    yyyy,
    "-",
    mm,
    "-",
    dd,
  ]);

  String selectdt1 = formatDate(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      [yyyy, "-", mm, "-", dd]);

  _showStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kblue,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        authController.date1 = picked;
        selectdt = formatDate(authController.date1.subtract(const Duration(days: 0)), [
          yyyy,
          "-",
          mm,
          "-",
          dd,
        ]);
      });
      authController.update();
    }
  }

  _showEndDate(BuildContext context) async {

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kblue,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        authController.date = picked;
        selectdt1 = formatDate(authController.date.add(const Duration(days: 0)), [
          yyyy,
          "-",
          mm,
          "-",
          dd,
        ]);
      });
    }
    authController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title:const Text("Education Skills"),
      ),
      body: ListView(
        children: [
          Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GetBuilder<ProfileController>(builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ksizedbox10,
                        profileController.educationskillsData.isEmpty
                            ? const Text('No data')
                            : ListView.builder(physics: const NeverScrollableScrollPhysics() ,
                                shrinkWrap: true,
                                itemCount: profileController.educationskillsData.length,
                                itemBuilder: (context, intex) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:const BoxDecoration(
                                                    color: Colors.grey
                                                  ),
                                                ),
                                                const SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                  Text(profileController.educationskillsData[intex].institutionName,
                                                  style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                                  Text(profileController.educationskillsData[intex].educationTitle,
                                                  style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w200),),
                                                  Text(profileController.educationskillsData[intex].tillDate.toString()),
                                              ],
                                            ),
                                              ],
                                            ),
                                             Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                  var schoolController = TextEditingController();
                                  var standardsController = TextEditingController();
                                  var cityController = TextEditingController();
                                  var stateController = TextEditingController();
                                  //var startdateController = TextEditingController();
                                  //var enddateController = TextEditingController();  

                                  schoolController.text = profileController.educationskillsData[intex].institutionName;
                                  standardsController.text = profileController.educationskillsData[intex].educationTitle;
                                  cityController.text = profileController.educationskillsData[intex].city;
                                  stateController.text = profileController.educationskillsData[intex].state;
                                  selectdt = profileController.educationskillsData[intex].fromBatch;
                                  selectdt1 = profileController.educationskillsData[intex].tillDate.toString();           

                           showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      18.0), // Adjust the radius as needed
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Fill Your School Details'),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red[500],
                                        ))
                                  ],
                                ),
                                content:const Text('Choose your education and update the required details.'),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        //  ksizedbox10,
                                        TextFormFieldWidget(
                                          labeltext: 'School name',
                                          controller: schoolController,
                                        ),
                                        ksizedbox10,
                                        TextFormFieldWidget(
                                          labeltext: 'Standards',
                                          controller: standardsController,
                                        ),
                                        // DropdownTextFieldWidgets(
                                        //   DropHintText: 'Standards',
                                        //   list: 'no data',
                                        // ),
                                        ksizedbox10,
                                        TextFormFieldWidget(
                                          labeltext: 'City',
                                          controller: cityController,
                                        ),
                                        // DropdownTextFieldWidgets(
                                        //   DropHintText: 'Selected City',
                                        //   list: 'no data',
                                        // ),
                                        ksizedbox10,
                                        TextFormFieldWidget(
                                          labeltext: ' State',
                                          controller: stateController,
                                        ),
                                        // DropdownTextFieldWidgets(
                                        //   DropHintText: 'Selected State',
                                        //   list: 'no data',
                                        // ),
                                        ksizedbox10,
                                        GetBuilder<AuthController>(
                                          builder: (_) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    _showStartDate(context);
                                                  },
                                                  child: Container(
                                                    width: 120,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[100],
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        selectdt
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: kgrey),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    _showEndDate(context);
                                                  },
                                                  child: Container(
                                                    width: 120,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[100],
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        selectdt1
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        ),
                                        ksizedbox10,
                                        InkWell(
                                          onTap: () {
                                            print(
                                                "-------->> chack values <<---------");
                                            print(schoolController.text);
                                            print(standardsController.text);
                                            authController.updateEducationSkills(
                                              institutionname: schoolController.text, 
                                              educationtitle: standardsController.text, 
                                              id: profileController.educationskillsData[intex].id.toString(), 
                                              city: cityController.text, 
                                              state: stateController.text, 
                                              frombatch: selectdt, 
                                              educationdescription: "", 
                                              tilldate: selectdt1);
                                            //   Get.back();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                color: kblue,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Center(
                                                child: Text(
                                              'Update',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: kwhite),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                                                  },
                                                  child: const Icon(Icons.edit_outlined,color: Colors.grey)),
                                              ],
                                            )
                                          ],
                                        ),
                                        
                                      ],
                                    ),
                                  );
                                }),
                      ],
                    );
                  })),
        ],
      ),
    );
  }
}