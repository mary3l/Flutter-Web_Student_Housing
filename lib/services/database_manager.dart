import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';

class HousingService {
  static Future<HousingModel> fetchHousingDetails(String housingId) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('student_housings')
        .doc(housingId)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data()
          as Map<String, dynamic>?; // Removed unnecessary cast
      if (data != null) {
        return HousingModel.fromMap(data);
      } else {
        throw Exception("Fetched data is null");
      }
    } else {
      throw Exception("Housing not found");
    }
  }
}
