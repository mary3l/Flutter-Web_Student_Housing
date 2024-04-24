// import 'package:flutter/material.dart';
// import 'package:flutter_finals_web/models/housing.dart';

// class HousingDetailsScreen extends StatelessWidget {
//   final HousingModel housing;

//   const HousingDetailsScreen({Key? key, required this.housing})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Housing Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 250,
//               child: ImageGallery(
//                 images: housing.housePhotoUrl,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     housing.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text('Price: ${housing.pricing}'),
//                   Text('Pets Allowed: ${housing.isPetsAllowed ? 'Yes' : 'No'}'),
//                   Text(
//                       'Visitors Allowed: ${housing.isVisitorsAllowed ? 'Yes' : 'No'}'),
//                   SizedBox(height: 20),
//                   Text('Rooms:',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   ...(housing.rooms)
//                       .map((room) => Text(room.roomType))
//                       .toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageGallery extends StatelessWidget {
//   final List<String> images;

//   const ImageGallery({Key? key, required this.images}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: images.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: Image.network(
//               images[index],
//               fit: BoxFit.cover,
//               width: 250,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
