import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_quest/models/announcement.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  static const String routeName = '/announcement_detail';

  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Announcement announcement =
        ModalRoute.of(context)!.settings.arguments as Announcement;
    final appColor = context.appColors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor.accent,
        title: Text(announcement.announcementTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnnouncementCarouselSlider(announcement: announcement),
            AnnouncementDetailContent(announcement: announcement),
          ],
        ),
      ),
    );
  }
}

class AnnouncementDetailContent extends StatelessWidget {
  const AnnouncementDetailContent({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    var date = announcement.announcementPublishedOn.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${formatter.format(DateTime.parse(date))}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  announcement.announcementDescription,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementCarouselSlider extends StatelessWidget {
  const AnnouncementCarouselSlider({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 2.0,
      ),
      items: announcement.announcementImages!.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: FullScreenImage(url: url),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: appColor.accent,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Hero(
                    tag: 'announcement_image_${url.hashCode}',
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          url,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigate back to the detail screen
        },
        child: PhotoView(
          imageProvider: NetworkImage(url),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
