import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_finals_web/models/housing.dart';

class HousingDetailsCard extends StatelessWidget {
  final HousingModel housing;

  const HousingDetailsCard({Key? key, required this.housing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Housing Details'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Row(
            children: [
              // Expanded(
              //   child: ImageGallery(images: housing.housePhotoUrl),
              // ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            10), // Set the border ra dius to 10
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${housing.name}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('Description: ${housing.description}'),
                            SizedBox(height: 10),
                            Text('Price: ${housing.pricing}'),
                            SizedBox(height: 10),
                            Text(
                                'Pets Allowed: ${housing.isPetsAllowed ? 'Yes' : 'No'}'),
                            SizedBox(height: 10),
                            Text(
                                'Visitors Allowed: ${housing.isVisitorsAllowed ? 'Yes' : 'No'}'),
                            SizedBox(height: 10),
                            Text('Contact Information:'),
                            Text('Email: ${housing.contactEmail}'),
                            Text('Mobile: ${housing.contactMobile}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> images;

  const ImageGallery({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    print('Error loading image: $imageUrl, $exception');
                    return Center(child: Text('Could not load image'));
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
