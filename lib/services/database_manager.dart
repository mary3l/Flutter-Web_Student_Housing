// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_finals_web/models/housing.dart';

// Future<List<HousingModel>> fetchHousingData() async {
//   final DatabaseReference dbRef =
//       FirebaseDatabase.instance.reference().child('housing');

//   // Use await to get the DataSnapshot directly
//   DataSnapshot dataSnapshot = await dbRef.once();

//   List<HousingModel> housingList = [];

//   // Check if dataSnapshot is not null
//   if (dataSnapshot.value != null) {
//     Map<dynamic, dynamic> housingData =
//         dataSnapshot.value as Map<dynamic, dynamic>; // Explicitly cast value

//     housingData.forEach((key, value) {
//       List<RoomModel> roomsList = [];

//       if (value['rooms'] != null) {
//         value['rooms'].forEach((roomKey, roomData) {
//           roomsList.add(RoomModel.fromMap(roomData));
//         });
//       }

//       List<ContactModel> contactsList = [];

//       if (value['contacts'] != null) {
//         value['contacts'].forEach((contactData) {
//           contactsList.add(ContactModel.fromMap(contactData));
//         });
//       }

//       HousingModel housingModel = HousingModel(
//         id: key,
//         description: value['description'],
//         isPetsAllowed: value['isPetsAllowed'],
//         isVisible: value['isVisible'],
//         isVisitorsAllowed: value['isVisitorsAllowed'],
//         name: value['name'],
//         pricing: value['pricing'],
//         rooms: roomsList,
//         contacts: contactsList,
//       );

//       housingList.add(housingModel);
//     });
//   }

//   return housingList;
// }
