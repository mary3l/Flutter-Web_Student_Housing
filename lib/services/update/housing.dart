import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';

class UpdateHousingService {
  // Reference to the 'housings' collection in Firestore
  final CollectionReference housingsCollection =
      FirebaseFirestore.instance.collection('student housings');

  Future<void> updateHousing(HousingModel updatedHousing) async {
    try {
      // Get the document ID of the housing to be updated
      QuerySnapshot querySnapshot = await housingsCollection
          .where('name', isEqualTo: updatedHousing.name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the first document found (assuming there's only one)
        String docId = querySnapshot.docs.first.id;
        await housingsCollection.doc(docId).update({
          'description': updatedHousing.description,
          'isPetsAllowed': updatedHousing.isPetsAllowed,
          'isVisible': updatedHousing.isVisible,
          'isVisitorsAllowed': updatedHousing.isVisitorsAllowed,
          'pricing': updatedHousing.pricing,
          'contactMobile': updatedHousing.contactMobile,
          'contactEmail': updatedHousing.contactEmail,
          'housePhotoUrl': updatedHousing.housePhotoUrl,
        });
        print('Housing updated successfully');
      } else {
        print('Housing not found.');
      }
    } catch (e) {
      print('Error updating housing: $e');
    }
  }
}
