import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';
import 'package:flutter_finals_web/widgets/housing_details_card.dart';

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

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // Navigate to housing details card when the card is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HousingDetailsCard(housing: housing),
                ),
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.2, // Set width to 20% of screen width
              child: Card(
                color: Colors.grey[900], // Set card color to grey[900]
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (housing.housePhotoUrl.isNotEmpty)
                    //   Expanded(
                    //     child: ImageGallery(
                    //       images: housing
                    //           .housePhotoUrl, // Ensures the image covers the available space without distorting aspect ratio
                    //     ),
                    //   ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius to 10
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email: ${housing.contactEmail}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Add space between email and name
                              Text(
                                housing.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4), // Adjust spacing as needed
                              Text(
                                'Contact Information:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                'Mobile: ${housing.contactMobile}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              // Add more Text widgets for additional details here
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                child: Image.network(
                  imageUrl,
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
