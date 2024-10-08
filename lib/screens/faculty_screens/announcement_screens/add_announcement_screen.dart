import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:event_quest/services/announcement_services.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddAnnouncementScreen extends StatefulWidget {
  static const String routeName = '/add-announcement-screen';
  const AddAnnouncementScreen({super.key});

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  List<File> images = [];
  bool submitted = false;
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  Future<List<File>> pickImages() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  void clearImage() {
    setState(() {
      images = [];
    });
  }

  AnnouncementServices announcementServices = AnnouncementServices();

  TextEditingController announcementTitle = TextEditingController();
  TextEditingController announcementDescription = TextEditingController();

  void addAnnouncement() {
    announcementServices.addAnnouncement(
        context: context,
        announcementTitle: announcementTitle.text,
        announcementDescription: announcementDescription.text,
        announcementImages: images,
        announcementPublishedOn: DateTime.now().toString());
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    ;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: announcementTitle,
                  decoration: InputDecoration(
                    labelText: "Announcement Title",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Announcement Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: announcementDescription,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Announcement Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Upload Image",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_outlined,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Upload Announcement Images",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: submitted == true ? null : clearImage,
                      label: const Text(
                        "Clear",
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (images.isEmpty) {
                              // If no image selected, show an alert dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: appColor.accent,
                                  title: Text(
                                    'Image Required',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  content: const Text(
                                      'Please select an image to upload.'),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: appColor.primary,
                                          foregroundColor: appColor.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              addAnnouncement();
                            }
                          }
                        },
                        child: const Text('Add Announcement')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
