import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';


class createpost extends StatefulWidget {
  const createpost({super.key});

  @override
  State<createpost> createState() => _createpostState();
}

class _createpostState extends State<createpost> {

 
  final postsController = Get.find<PostsController>();
  var textController = TextEditingController();
  File? image;


  @override
  Widget build(BuildContext context) {
    //  var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GetBuilder<PostsController>(builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create Post',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              postsController.isLoading.isTrue
                  ? Container(
                      height: 26,
                      width: 60,
                      decoration: BoxDecoration(
                          color: kblue,
                          borderRadius: BorderRadiusDirectional.circular(18)),
                      child: Center(
                          child: Container(
                        height: 20,
                        width: 20,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )),
                    )
                  : InkWell(
                      onTap: () {
                        if (image != null) {
                          postsController.uplodPost(
                              title: textController.text,
                              description: "",
                              media: File(image!.path));
                        } else if (textController.text.isNotEmpty) {
                          postsController.uplodPostText(
                            title: textController.text,
                            description: "",
                          );
                        } else {
                          Get.rawSnackbar(
                            messageText: const Text(
                              "Complete before posting",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      child: Container(
                        height: 26,
                        width: 60,
                        decoration: BoxDecoration(
                            color: kblue,
                            borderRadius: BorderRadiusDirectional.circular(18)),
                        child: Center(
                            child: Text(
                          'Post',
                          style: TextStyle(color: kwhite, fontSize: 15),
                        )),
                      ),
                    )
            ],
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<PostsController>(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ksizedbox40,
                Row(
                  children: [
                    postsController.profileData.first.profilePicture == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/profil_img.jpeg'),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(postsController
                                .profileData.first.profilePicture),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${postsController.profileData.first.name}\n${postsController.profileData.first.userName}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                ksizedbox10,
                ksizedbox30,
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: textController,
                  minLines: 4,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorHeight: 15,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(
                      15,
                    ),
                    hintText: "What do you want to Talk about?",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1.2, color: Colors.grey)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1.2, color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1.2, color: Colors.grey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1.2, color: Colors.grey)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your message";
                    }
                    return null;
                  },
                ),
                ksizedbox40,
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? timage =
                        await _picker.pickImage(source: ImageSource.gallery);

                    final croppedImage = await ImageCropper().cropImage(
                      sourcePath: timage!.path,
                      aspectRatioPresets: [CropAspectRatioPreset.ratio7x5],
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: kblue,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        IOSUiSettings(
                          title: 'Cropper',
                        ),
                        WebUiSettings(
                          context: context,
                        ),
                      ],
                    );

                    if (croppedImage == null) return;

                    final croppedFile = File(croppedImage.path);

                    setState(() {
                      image = croppedFile;
                    });
                    // setState(() {
                    //   image = File(timage!.path);
                    // });
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: kblue,
                        borderRadius: BorderRadiusDirectional.circular(18)),
                    child: Center(
                        child: Text(
                      'Upload',
                      style: TextStyle(color: kwhite, fontSize: 17),
                    )),
                  ),
                ),
                ksizedbox30,
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(image!.path)),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
