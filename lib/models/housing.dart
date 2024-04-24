class HousingModel {
  final String? id;
  final String description;
  final bool isPetsAllowed;
  final bool isVisible;
  final bool isVisitorsAllowed;
  final String name;
  final int pricing;
  final int contactMobile;
  final String contactEmail;
  // final Map<String, RoomModel> rooms;
  final List<String> housePhotoUrl;

  HousingModel({
    this.id,
    required this.description,
    required this.isPetsAllowed,
    required this.isVisible,
    required this.isVisitorsAllowed,
    required this.name,
    required this.pricing,
    required this.contactEmail,
    required this.contactMobile,
    required this.housePhotoUrl,
  });

  factory HousingModel.fromMap(Map<String, dynamic> map) {
    // var contactsMap = (map['contacts'] as Map<String, dynamic>).map(
    //   (key, value) => MapEntry(key, ContactModel.fromMap(value)),
    // );
    // var roomsMap = (map['rooms'] as Map<String, dynamic>).map(
    //   (key, value) => MapEntry(key, RoomModel.fromMap(value)),
    // );
    var photoUrls = List<String>.from(map['housePhotoUrl'] ?? []);

    return HousingModel(
      // id: documentId,
      description: map['description'] ?? '',
      isPetsAllowed: map['isPetsAllowed'] ?? false,
      isVisible: map['isVisible'] ?? false,
      isVisitorsAllowed: map['isVisitorsAllowed'] ?? false,
      name: map['name'] ?? '',
      pricing: map['pricing'] ?? 0,
      contactEmail: map['contactEmail'] ?? '',
      contactMobile: map['contactMobile'] ?? 0,
      // rooms: roomsMap,
      housePhotoUrl: photoUrls,
    );
  }
}

class RoomModel {
  final String roomId;
  final String roomType;
  final int maxCapacity;
  final int pricing;
  final bool isVacant;
  final bool hasOwnBathroom;
  final List<String> roomPhotoUrl;

  RoomModel({
    required this.roomId,
    required this.roomType,
    required this.maxCapacity,
    required this.pricing,
    required this.isVacant,
    required this.hasOwnBathroom,
    required this.roomPhotoUrl,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? '',
      roomType: map['roomType'] ?? '',
      maxCapacity: map['maxCapacity'] ?? 0,
      pricing: map['pricing'] ?? 0,
      isVacant: map['isVacant'] ?? false,
      hasOwnBathroom: map['hasOwnBathroom'] ?? false,
      roomPhotoUrl: List<String>.from(map['roomPhotoUrl'] ?? []),
    );
  }
}
