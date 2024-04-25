import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';

class HousingCard extends StatelessWidget {
  final String housingId;

  const HousingCard({Key? key, required this.housingId}) : super(key: key);

  // Fetching housing details from Firestore
  Future<HousingModel> fetchHousingDetails() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('student housings')
        .doc(housingId)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        // print('data here', data);
        return HousingModel.fromMap(data);
      } else {
        throw Exception("Fetched data is null");
      }
    } else {
      throw Exception("Housing not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HousingModel>(
      future: fetchHousingDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('Housing not found');
        }

        HousingModel housing = snapshot.data!;

        return Card(
          color: Colors.grey[900], // Set card color to grey[900]
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (housing.housePhotoUrl.isNotEmpty)
                ImageGallery(
                  images: housing.housePhotoUrl,
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      housing.name,
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Price: ${housing.pricing}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Contact Information:',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Email: ${housing.contactEmail}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    Text(
                      'Mobile: ${housing.contactMobile}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
