import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StaggeredGalleryView extends StatelessWidget {
  // Your image URLs
  final List<String> imageUrls = [
    'https://petromasteracademy.com/assets4/images/gallery/1702883070.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1702883201.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1702883211.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1702883258.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1702883311.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1702883408.jpg',
    'https://petromasteracademy.com/assets4/images/gallery/1703146082.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1703146095.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1703146104.jpeg',
    'https://petromasteracademy.com/assets4/images/gallery/1705388633.jpg',
    'https://petromasteracademy.com/assets4/images/gallery/1705388654.jpg',
    'https://petromasteracademy.com/assets/images/1754992275.jpeg',
    'https://petromasteracademy.com/assets/images/1754992269.jpeg',
    'https://petromasteracademy.com/assets/images/1754992264.jpeg',
    'https://petromasteracademy.com/assets/images/1754992264.jpeg',
    'https://petromasteracademy.com/assets/images/1754992235.jpeg',
    'https://petromasteracademy.com/assets/images/1754992229.jpeg',
    'https://petromasteracademy.com/assets/images/1754992220.jpeg',
    'https://petromasteracademy.com/assets/images/1754992212.jpeg',
    'https://petromasteracademy.com/assets/images/1754992205.jpeg',
    'https://petromasteracademy.com/assets/images/1705388654.jpg',
    'https://petromasteracademy.com/assets/images/1705388633.jpg'
  ];

  StaggeredGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 8.0, // Vertical spacing
        crossAxisSpacing: 8.0, // Horizontal spacing
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GalleryItem(
            imageUrl: imageUrls[index],
            index: index,
          );
        },
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  final String imageUrl;
  final int index;

  const GalleryItem({
    Key? key,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to full-screen image view
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageView(
              imageUrl: imageUrl,
              tag: 'gallery_image_$index',
            ),
          ),
        );
      },
      child: Hero(
        tag: 'gallery_image_$index',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child:
             CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImageView({
    Key? key,
    required this.imageUrl,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Hero(
              tag: tag,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
