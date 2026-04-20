import 'package:petromaster/core/utils/debuprint.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../app/config/routes/route_name.dart';
import '../../../../../../domain/models/videolist_model.dart';
import '../../../../viewmodel/videolistvm.dart';

class VideoListItem extends StatelessWidget {
  final VideoModel videoData;

  const VideoListItem({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoVM = Get.find<VideolistVM>();
    // Parse the timestamp
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(videoData.dateTime.toString()) * 1000);
    final formattedDate = DateFormat('MMM d, y').format(dateTime);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: InkWell(
        onTap: () async {
          await videoVM.videoseen(videoData.videoId.toString());
          consolePrint('videourl is ${videoData.name}');
          Get.toNamed(RouteName.videoplayer, arguments: videoData.name);
          // Handle video tap
          // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: videoData['name'])));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with play button
            Stack(
              alignment: Alignment.center,
              children: [
                // Thumbnail placeholder (replace with actual thumbnail if available)
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: videoData.thumbnail != null
                      ? CachedNetworkImage(
                          imageUrl: videoData.thumbnail!.trim(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.videocam,
                                  size: 50, color: Colors.grey),
                            );
                          },
                          placeholder: (context, url) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.videocam,
                                  size: 50, color: Colors.grey),
                            );
                          },
                        )
                      : const Icon(Icons.videocam,
                          size: 50, color: Colors.grey),
                ),
                // Play button
                const CircleAvatar(
                  backgroundColor: Colors.white54,
                  child: Icon(Icons.play_arrow, color: Colors.black),
                ),
              ],
            ),
            // Video details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video title
                  Text(
                    videoData.videoname ?? 'Untitled Video',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Upload date and visibility
                  Row(
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        videoData.pMode == 'public' ? Icons.public : Icons.lock,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  // Description if available
                  if (videoData.description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        videoData.description ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
