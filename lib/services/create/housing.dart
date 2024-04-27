import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';

class CreateHousingService {
  // Reference to the 'housings' collection in Firestore
  final CollectionReference housingsCollection =
      FirebaseFirestore.instance.collection('student housings');

  Future<void> addHousing(HousingModel housing) async {
    try {
      // Add a new document with a generated ID
      await housingsCollection.add({
        'description': housing.description,
        'isPetsAllowed': housing.isPetsAllowed,
        'isVisible': housing.isVisible,
        'isVisitorsAllowed': housing.isVisitorsAllowed,
        'name': housing.name,
        'pricing': housing.pricing,
        'contactMobile': housing.contactMobile,
        'contactEmail': housing.contactEmail,
        'housePhotoUrl': housing.housePhotoUrl,
      });
      print('Housing added successfully');
    } catch (e) {
      print('Error adding housing: $e');
    }
  }
}
