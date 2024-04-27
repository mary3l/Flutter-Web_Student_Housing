import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/models/housing.dart';

class HousingService {
  final String housingId;

  HousingService({required this.housingId});

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
}
