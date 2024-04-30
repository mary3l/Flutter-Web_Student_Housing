import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_finals_web/models/housing.dart';
import 'package:flutter_finals_web/widgets/update_button.dart';

class HousingDetailsCard extends StatefulWidget {
  final HousingModel housing;

  const HousingDetailsCard({Key? key, required this.housing}) : super(key: key);

  @override
  _HousingDetailsCardState createState() => _HousingDetailsCardState();
}

class _HousingDetailsCardState extends State<HousingDetailsCard> {
  late bool _isVisible; // Declare _isVisible

  @override
  void initState() {
    super.initState();
    _isVisible = widget.housing.isVisible; // Initialize based on housing data
  }

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
              Expanded(
                child: ImageGallery(images: widget.housing.housePhotoUrl),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name: ${widget.housing.name}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UpdateButton(
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('Description: ${widget.housing.description}'),
                            SizedBox(height: 10),
                            Text('Price: ${widget.housing.pricing}'),
                            SizedBox(height: 10),
                            Text(
                                'Pets Allowed: ${widget.housing.isPetsAllowed ? 'Yes' : 'No'}'),
                            SizedBox(height: 10),
                            Text(
                                'Visitors Allowed: ${widget.housing.isVisitorsAllowed ? 'Yes' : 'No'}'),
                            SizedBox(height: 10),
                            Text('Contact Information:'),
                            Text('Email: ${widget.housing.contactEmail}'),
                            Text('Mobile: ${widget.housing.contactMobile}'),
                            SwitchListTile(
                              title: Text('Visible'),
                              value: _isVisible,
                              onChanged: (bool value) async {
                                // Call the updateStatus function with the desired id when the switch is toggled
                                // print('Housing ID: ${widget.housing.id}');

                                bool updateSuccessful = await updateStatus(
                                    id: widget.housing
                                        .id!); // Replace 'yourDocumentId' with the actual document ID
                                if (updateSuccessful) {
                                  setState(() {
                                    _isVisible =
                                        value; // Update state on toggle only if update is successful
                                  });
                                } else {
                                  // Optionally handle the error, e.g., by showing a Snackbar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Failed to update visibility"),
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              },
                            ),
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

  Future<bool> updateStatus({required String id}) async {
    try {
      final _db = FirebaseFirestore.instance;
      final itemRef = _db.collection("student housings").doc(id);
      final itemSnapshot = await itemRef.get();
      final bool isVisible = itemSnapshot.get("isVisible");

      await itemRef.update({"isVisible": !isVisible});

      // refresh items list after adding new item
      // clearItems();
      // getAllItems();

      // notifyListeners();

      return true;
    } catch (e) {
      print("Failed to upload\n\n$e");
      return false;
    }
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
